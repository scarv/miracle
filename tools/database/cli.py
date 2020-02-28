#!/usr/bin/python3

"""
Front-end CLI for the leakage database
"""

import ast
import sys
import os
import gzip
import argparse
import datetime
import logging  as log
import configparser

import numpy as np

import ldb

ENTITY_CORES        = "cores"
ENTITY_DEVICES      = "devices"
ENTITY_BOARDS       = "boards"
ENTITY_TARGETS      = "targets"
ENTITY_EXPERIMENTS  = "experiments"
ENTITY_TTRACESETS   = "ttrace-sets"
ENTITY_TRACESETBLOBS= "traceset-blobs"
ENTITY_VARIABLEVALUE= "variable-values"
ENTITY_STAT_TRACES  = "statistic-traces"
ENTITY_CORR_TRACES  = "corrolation-traces"

#
# Possible entity types we can list in the database.
list_command_options = [
    ENTITY_CORES        ,
    ENTITY_DEVICES      ,
    ENTITY_BOARDS       ,
    ENTITY_TARGETS      ,
    ENTITY_EXPERIMENTS  ,
    ENTITY_TTRACESETS   ,
    ENTITY_TRACESETBLOBS,
    ENTITY_VARIABLEVALUE,
    ENTITY_STAT_TRACES  ,
    ENTITY_CORR_TRACES
]

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

        backend.pushAutoCommit(False)

        for cfg_path in args.from_cfg:
            cfg    = configparser.ConfigParser()
            cfg.read(cfg_path)

            core    = ldb.records.Core.fromCFGDict(cfg)
            board   = ldb.records.Board.fromCFGDict(cfg)
            device  = ldb.records.Device.fromCFGDict(cfg)

            if(backend.getCoreByName(core.name) == None):
                backend.insertCore(core)
            else:
                core = backend.getCoreByName(core.name)
                log.warn("Skipping core '%s', already exists." % core.name)

            if(backend.getBoardByName(board.name) == None):
                backend.insertBoard(board)
            else:
                board = backend.getBoardByName(board.name)
                log.warn("Skipping board '%s', already exists." % board.name)

            if(backend.getDeviceByName(device.name) == None):
                backend.insertDevice(device)
            else:
                device = backend.getDeviceByName(device.name)
                log.warn("Skipping device '%s', already exists." % device.name)

            target  = ldb.records.Target.fromCFGDict(
                cfg, device.id, board.id, core.id
            )

            if(backend.getTargetByName(target.name) == None):
                backend.insertTarget(target)
            else:
                log.warn("Skipping target '%s', already exists." % target.name)

            backend.commit()

        backend.popAutoCommit()

    else:
        log.warn("No target information to insert!")

    return 0


def commandListEntries(args):
    """
    A simple way to print out entries in the database.
    """
    assert(args.entity in list_command_options)
    backend = connectToBackend(args.dbpath, args.backend)

    items = []

    if  (args.entity == ENTITY_CORES):
        items = backend.getAllCores()

    elif(args.entity == ENTITY_DEVICES):
        items = backend.getAllDevices()

    elif(args.entity == ENTITY_BOARDS):
        items = backend.getAllBoards()
    
    elif(args.entity == ENTITY_TARGETS):
        items = backend.getAllTargets()
    
    elif(args.entity == ENTITY_EXPERIMENTS):
        items = backend.getAllExperiments()
    
    elif(args.entity == ENTITY_TTRACESETS):
        items = backend.getAllTTraceSets()
    
    elif(args.entity == ENTITY_TRACESETBLOBS):
        items = backend.getAllTraceSetBlobs()
    
    elif(args.entity == ENTITY_VARIABLEVALUE):
        items = backend.getAllVariableValues()
    
    elif(args.entity == ENTITY_STAT_TRACES):
        items = backend.getAllStatisticTraces()
    
    elif(args.entity == ENTITY_CORR_TRACES):
        items = backend.getAllCorrolationTraces()

    else:
        assert(False),"Should be unreachable!"
    
    for item in items:
        print(item)

    return 0


def showTTraceSet(backend, ttraceSet):
    """
    Print information on the TTrace set.
    """
    experiment  = backend.getExperimentById(ttraceSet.experimentId)
    target      = backend.getTargetById(ttraceSet.targetId)
    fixed       = ttraceSet.fixedTraceSet
    random      = ttraceSet.randomTraceSet

    parameters  = ast.literal_eval(ttraceSet.parameters)

    print("TTraceSet captured at %s" % ttraceSet.timestamp)
    print("Experiment: %s" % experiment.name)
    print("Target    : %s" % target.name)
    print("Parameters:")
    for p in parameters:
        print("- %-7s : %s" % (p, parameters[p]))

    print("Fixed  Traces: %5d traces, %5d long" % fixed.shape)

    for var in fixed.variableValues:
        print("- %-5s id=%d, %d values" % (var.varname, var.id,var.num_values))

    print("Random Traces: %5d traces, %5d long" % random.shape)
    for var in random.variableValues:
        print("- %-5s id=%d, %d values" % (var.varname, var.id,var.num_values))

    return 0


def commandShow(args):
    """
    Show all information on a specific object in the database.
    """
    backend = connectToBackend(args.dbpath, args.backend)

    if(args.entity == ENTITY_TTRACESETS):

        ttraceSet = backend.getTTraceSetsById(args.id)

        if(ttraceSet == None):
            log.error("No TTraceSet exists with id '%d'" % args.id)
            return 1
        else:
            return showTTraceSet(backend, ttraceSet)

    else:
        log.error("Functionality not implemented: 'show %s'" % args.entity)
        return 1

    return 0


def commandRemove(args):
    """
    Implements removal operations for entities in the database.
    """
    backend = connectToBackend(args.dbpath, args.backend)

    if(args.entity == ENTITY_TTRACESETS):

        backend.pushAutoCommit(False)

        if(args.all):

            for ts in backend.getAllTTraceSets():
                backend.removeTTraceSet(ts.id)

        else:
            for tsid in args.id:
                ttraceSet = backend.getTTraceSetsById(tsid)

                if(ttraceSet == None):
                    log.error("No TTraceSet exists with id '%d'" % tsid)
                    return 1

                backend.removeTTraceSet(ttraceSet.id)

        backend.popAutoCommit()

        backend.commit()

    elif(args.entity == ENTITY_CORR_TRACES):

        backend.pushAutoCommit(False)

        if(args.all):
            for ct in backend.getAllCorrolationTraces():
                backend.removeCorrolationTrace(ct.id)
        else:
            for ctid in args.id:
                corrtrace = backend.getCorrolationTraceById(ctid)

                if(corrtrace== None):
                    log.error("No Corrolation Trace exists with id '%d'" % ctid)
                    return 1

                backend.removeCorrolationTrace(corrtrace.id)

        backend.popAutoCommit()
        backend.commit()

    elif(args.entity == ENTITY_EXPERIMENTS):

        backend.pushAutoCommit(False)

        if(args.all):
            for ct in backend.getAllExperiments():
                backend.removeExperiment(ct.id)
        else:
            for ctid in args.id:
                experiment = backend.getExperimentById(ctid)

                if(experiment == None):
                    log.error("No Experiment exists with id '%d'" % ctid)
                    return 1

                backend.removeExperiment(experiment.id)

        backend.popAutoCommit()
        backend.commit()

    else:
        log.error("Functionality not implemented: 'remove %s'" % args.entity)
        return 1

    return 0


def commandPlot(args):
    """
    Uses Matplotlib to show a simple average trace plot for the supplied
    trace blob.
    """
    backend = connectToBackend(args.dbpath, args.backend)

    blob    = backend.getTraceSetBlobById(args.blob_id)

    if(blob == None):
        log.error("Unknown blob id '%d'" % args.blob_id)

    traces  = blob.getTracesAsNdArray()

    import matplotlib.pyplot as plt

    plt.figure()
    plt.plot(traces)
    plt.show()

    return 0


def commandInsertExperiment(args):
    """
    For inserting experiments into the database.
    If the supplied name/catagory combination already exists, then
    print the id of the existing entry. Otherwise print the id of
    the new entry.
    """
    backend = connectToBackend(args.dbpath, args.backend)

    existing = backend.getExperimentByCatagoryAndName(
        args.catagory,
        args.name
    )

    if(existing == None):

        newExperiment = ldb.records.Experiment(
            name        = args.name,
            catagory    = args.catagory,
            description = args.description
        )

        backend.insertExperiment(newExperiment)
        backend.commit()

        print(newExperiment.id)

    else:

        print(existing.id)

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

    parser.add_argument("--log", type=str,
        help = "Filepath to log too."
    )

    subparsers  = parser.add_subparsers(
        title="Sub-commands",
        dest="command"
    )
    subparsers.required = True
    
    #
    # Arguments for listing entries in the database
    
    parser_add_target = subparsers.add_parser("list",
        help="list entries in the database")
    
    parser_add_target.set_defaults(func=commandListEntries)

    parser_add_target.add_argument("entity", type=str, 
        choices=list_command_options,
        help="What sort of entity type in the database to list.")

    #
    # Arguments for inserting a new target, board, device and core from
    # A config used by the browser tool
    
    parser_add_target = subparsers.add_parser("insert-targets",
        help="Insert a new target into the database")
    
    parser_add_target.set_defaults(func=commandInsertTargets)

    parser_add_target.add_argument("--from-cfg", type=str, nargs="+",
        help="Insert Target, Device, Board and Core information from the supplied cfg file.")

    #
    # Arguments for adding a new experiment to the database

    parser_add_experiment = subparsers.add_parser("insert-experiment",
        help = "Add a new experiment to the database. If the experiment already exists, it is not updated.")
    
    parser_add_experiment.set_defaults(func=commandInsertExperiment)
    
    parser_add_experiment.add_argument("--catagory","-c", type=str,
        default = "miscellaneous",
        help="Catagory to which the experiment belongs.")
    
    parser_add_experiment.add_argument("--description","-d", type=str,
        default="",
        help="A short description of the experiment")

    parser_add_experiment.add_argument("name", type=str,
        help="The name of the experiment")
    

    #
    # Arguments for initialising a new database

    parser_init = subparsers.add_parser("init",
        help="Create a new database file")

    parser_init.set_defaults(func=commandInit)

    parser_init.add_argument("--soft", action="store_true",
        help="Don't raise an error if the destination file already exists.")
    
    parser_init.add_argument("--force", action="store_true",
        help="Remove the existing database file if it already exists.")

    #
    # Arguments for showing information on things

    parser_show = subparsers.add_parser("show",
        help="Show information on an object in the database")
    
    parser_show.set_defaults(func=commandShow)

    parser_show.add_argument("entity", type=str, 
        choices=list_command_options,
        help="What sort of entity type in the database to show.")
    
    parser_show.add_argument("id", type=int,
        help="Unique ID of the entity to show")

    #
    # Arguments for manually deleteing things

    parser_rm= subparsers.add_parser("remove",
        help="Remove an entity (and possible sub-entities) from the database.")
    
    parser_rm.set_defaults(func=commandRemove)

    parser_rm.add_argument("entity", type=str, 
        choices=list_command_options,
        help="What sort of entity type in the database to remove.")
    
    parser_rm_grp = parser_rm.add_mutually_exclusive_group(required = True)
    
    parser_rm_grp.add_argument("--id", type=int, nargs="+",
        help="Unique ID of the entity to remove")
    
    parser_rm_grp.add_argument("--all", action="store_true",
        help="Remove all entities of this type.")


    #
    # Arguments for plotting

    parser_plot = subparsers.add_parser("plot",
        help="Tools for creating simple plots from trace blobs")

    parser_plot.set_defaults(func = commandPlot)

    parser_plot_grp = parser_plot.add_mutually_exclusive_group(required=True)

    parser_plot_grp.add_argument("--blob-id", type=int,
        help="The ID of the traceset_blob to plot.")

    return parser


def main():
    """
    CLI main function
    """
    parser      = buildArgParser()
    args        = parser.parse_args()

    log_level   = log.WARN
    log_file    = args.log

    if(args.verbose):
        log_level = log.INFO

    log.basicConfig(filename = log_file, level=log_level)


    result = args.func(args)

    return result


if(__name__=="__main__"):
    rcode = main()
    sys.exit(rcode)
