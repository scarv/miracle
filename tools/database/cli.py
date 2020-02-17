#!/usr/bin/python3

"""
Front-end CLI for the leakage database
"""

import sys
import os
import argparse
import logging  as log
import configparser

import ldb

def connectToBackend(path, backend):
    """
    Returns an appropriate instance of a database backend based on
    the supplied path and backend parameters.
    """
    if(backend == "sqlite"):
        return ldb.backend.SQLiteBackend("sqlite:///"+path)
    else:
        raise Exception("Unknown backend '%s'" % backend)


def commandInit(args):
    """
    Called when "init" is specified on the command line.
    """

    backend = None

    if(args.backend == "sqlite"):
        backend = ldb.backend.SQLiteBackend
    else:
        raise Exception("Invalid backend string: '%s'" % args.backend)

    file_exists = os.path.isfile(args.dbpath)

    if(file_exists and not args.soft and not args.force):
        log.error("The file '%s' already exists!" % args.dbpath)
        return 1
    elif(file_exists and args.soft and not args.force):
        log.info("The file '%s' already exists." % args.dbpath)
        return 0

    if(file_exists and args.force):
        log.warning("Removing pre-existing file '%s'" % args.dbpath)
        os.remove(args.dbpath)

    backend.createNew(args.dbpath)

    log.info("Created new %s backed database at %s" % (
        args.backend, args.dbpath))

    return 0


def commandInsertTargets(args):
    """
    Inserts a target device based on a description cfg of the type
    used by the browser tool.
    """

    if(args.from_cfg):

        backend = connectToBackend(args.dbpath, args.backend)
        backend.autocommit = False

        for cfg_path in args.from_cfg:
            cfg    = configparser.ConfigParser()
            cfg.read(cfg_path)

            core    = ldb.records.Core.fromCFGDict(cfg)
            board   = ldb.records.Board.fromCFGDict(cfg)
            device  = ldb.records.Device.fromCFGDict(cfg)

            if(backend.getCoreByName(core.name) == None):
                backend.insertCore(core)
            else:
                log.warn("Skipping core '%s', already exists." % core.name)

            if(backend.getBoardByName(board.name) == None):
                backend.insertBoard(board)
            else:
                log.warn("Skipping board '%s', already exists." % board.name)

            if(backend.getDeviceByName(device.name) == None):
                backend.insertDevice(device)
            else:
                log.warn("Skipping device '%s', already exists." % device.name)

            target  = ldb.records.Target.fromCFGDict(
                cfg, device.id, board.id, core.id
            )

            if(backend.getTargetByName(target.name) == None):
                backend.insertTarget(target)
            else:
                log.warn("Skipping target '%s', already exists." % target.name)

            backend.commit()

    else:
        log.warn("No target information to insert!")

    return 0


def buildArgParser():
    """
    Return the ArgumentParser object used to parse command line arguments
    to the CLI app.
    """

    parser      = argparse.ArgumentParser()

    parser.add_argument("dbpath", type=str, 
        help="File-path of the database")

    parser.add_argument("--backend", choices=["sqlite"],
        default="sqlite", help="Database Backend To Use")

    parser.add_argument("--verbose","-v",action="store_true",
        help="Turn on verbose logging.")

    subparsers  = parser.add_subparsers(
        title="Sub-commands",
        dest="command"
    )
    subparsers.required = True

    #
    # Arguments for inserting a new target, board, device and core from
    # A config used by the browser tool
    
    parser_add_target = subparsers.add_parser("insert-targets",
        help="Insert a new target into the database")
    
    parser_add_target.set_defaults(func=commandInsertTargets)

    parser_add_target.add_argument("--from-cfg", type=str, nargs="+",
        help="Insert Target, Device, Board and Core information from the supplied cfg file.")

    #
    # Arguments for initialising a new database

    parser_init = subparsers.add_parser("init",
        help="Create a new database file")

    parser_init.set_defaults(func=commandInit)

    parser_init.add_argument("--soft", action="store_true",
        help="Don't raise an error if the destination file already exists.")
    
    parser_init.add_argument("--force", action="store_true",
        help="Remove the existing database file if it already exists.")

    return parser


def main():
    """
    CLI main function
    """
    parser = buildArgParser()
    args   = parser.parse_args()

    if(args.verbose):
        log.basicConfig(level=log.INFO)
    else:
        log.basicConfig(level=log.WARN)

    result = args.func(args)

    return result


if(__name__=="__main__"):
    rcode = main()
    sys.exit(rcode)
