#!/usr/bin/python3

"""
Front-end CLI for the leakage database
"""

import sys
import os
import argparse
import logging  as log

import ldb


def commandInit(args):
    """
    Called when "init" is specified on the command line.
    """

    backend = None

    if(args.backend == "sqlite"):
        backend = ldb.backend.SQLiteBackend
    else:
        raise Exception("Invalid backend string: '%s'" % args.backend)

    file_exists = os.path.isfile(args.dbfile)

    if(file_exists and not args.soft):
        log.error("The file '%s' already exists!" % args.dbfile)
        return 1
    elif(file_exists and args.soft):
        log.info("The file '%s' already exists." % args.dbfile)
        return 0

    backend.createNew(args.dbfile)

    log.info("Created new %s backed database at %s" % (
        args.backend, args.dbfile))

    return 0


def buildArgParser():
    """
    Return the ArgumentParser object used to parse command line arguments
    to the CLI app.
    """

    parser      = argparse.ArgumentParser()

    parser.add_argument("--verbose","-v",action="store_true",
        help="Turn on verbose logging.")

    subparsers  = parser.add_subparsers(
        title="Sub-commands",
        dest="command"
    )
    subparsers.required = True

    #
    # Arguments for initialising a new database

    parser_init = subparsers.add_parser("init",
        help="Create a new database file")

    parser_init.set_defaults(func=commandInit)

    parser_init.add_argument("--backend", choices=["sqlite"],
        default="sqlite", help="Database Backend To Use")

    parser_init.add_argument("--soft", action="store_true",
        help="Don't raise an error if the destination file already exists")

    parser_init.add_argument("dbfile", type=str, 
        help="File-path of the new database")

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
