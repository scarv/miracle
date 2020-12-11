#!/usr/bin/python3

"""
Toolscript for orchestrating trace analysis within the database
"""

import sys
import os
import gzip
import argparse
import datetime
import logging  as log
import configparser
import importlib

import numpy as np

sys.path.append(os.path.expandvars("$MIR_DB_REPO_HOME"))
sys.path.append(os.path.expandvars("$UAS_ROOT/extern/fw-acquisition"))

import ldb
from ldb.records import TraceSetBlob
import scass

from AnalysisInterface import AnalysisInterface

def connectToBackend(path, backend):
    """
    Returns an appropriate instance of a database backend based on
    the supplied path and backend parameters.
    """
    if(backend == "sqlite"):
        return ldb.backend.SQLiteBackend("sqlite:///"+path)
    else:
        raise Exception("Unknown backend '%s'" % backend)


def loadExperimentModule(experiment_path):
    
    experiment_dir = os.path.expandvars(experiment_path)
    module_file    = os.path.join(experiment_dir, "ExperimentFlow.py")

    if(not os.path.isdir(experiment_dir)):
        
        log.error("Experiment source directory '%s' does not exist." % (
            experiment_dir
        ))

        log.error("Is the 'experiment' command line argument ('%s') correct?" %
            experiment_path
        )

        return 1

    elif(not os.path.isfile(module_file)):

        log.error("Cannot find experiment flow module '%s'" %(
            module_file
        ))

        return 1

    sys.path.append(experiment_dir)

    import ExperimentFlow as ef
    importlib.invalidate_caches()

    log.info("Loaded module '%s': '%s'" % (ef.__name__, experiment_path))

    sys.path.pop(-1)

    return ef


def getTargets(db, targetNames):
    """
    Return a list of ldb.records.Target objects based on the supplied names.
    If the supplied list is None, return all targets.

    Returns None if one of the target names does not exist in the database.
    """

    if(targetNames == None):
        return db.getAllTargets()

    tr = []
    
    for name in targetNames:
        
        tgt = db.getTargetByName(name)

        if(tgt == None):
            
            log.error("No target device with name '%s' in database."%name)
            
            return None

        else:

            tr.append(tgt)

    return tr


def getExperiment(db, experimentName):
    """
    Return a list of ldb.records.Experiment objects based on the supplied
    name.

    Returns None if the Experiment name does not exist in the database.
    """

    catagory,name = experimentName.split("/")
    exp = db.getExperimentByCatagoryAndName(catagory, name)

    if(exp == None):
        
        log.error("No Experiment with catagory '%s' and name '%s' in database."%(catagory, name))
        
        return None

    else:

        return exp


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

    parser.add_argument("--experiment-base-path", type=str,
        default = os.path.expandvars("$UAS_ROOT/experiments"),
        help="Default root path to experiment flow modules")

    parser.add_argument("--force", action="store_true",
        help="Run the analysis even if it is already present in the database")

    parser.add_argument("experiment", type=str,
        help = "Name of the experiment to run the analysis for.")

    parser.add_argument("--targets", type=str, nargs="+",
        help = "Name of the target devices to run the analysis for.")

    parser.add_argument("--delete-traces-after-analysis",action="store_true",
        help="Delete raw trace blobs corresponding to the current target and experiment from the database after analysis has completed.")

    parser.add_argument("--clean-useless-blobs",action="store_true",
        help="Delete raw trace blobs which have no derived statistic traces once analysis is complete.")

    return parser

    
def main():
    """
    CLI main function
    """
    parser = buildArgParser()
    args   = parser.parse_args()

    log_level   = log.WARN
    log_file    = args.log

    if(args.verbose):
        log_level = log.INFO

    log.basicConfig(filename = log_file, level=log_level)

    db = connectToBackend(args.dbpath, args.backend)

    target_set      = getTargets(db, args.targets)

    if(target_set == None):
        return 1

    experiment      = getExperiment(db, args.experiment)

    if(experiment == None):
        return 1

    esubpath= "%s/%s" % (experiment.catagory, experiment.name)
    epath   = os.path.join(args.experiment_base_path, esubpath)

    emod = loadExperimentModule(epath)
    log.info(emod.__file__)

    for target in target_set:

        log.info("Analysing %s/%s for %s" % (
            experiment.catagory, experiment.name, target.name))

        aif = AnalysisInterface(
            db, target, experiment, force = args.force
        )

        if(hasattr(emod, "runAnalysis")):
            emod.runAnalysis(aif)
        else:
            aif.runDefaultAnalysis()

        if(args.delete_traces_after_analysis):
            log.info("Deleting trace blobs now analysis is complete")
            blobs = db.getTraceSetBlobByTargetAndExperiment(
                target.id, experiment.id).filter(
                    TraceSetBlob.traces!=None).all()
            log.info("- %d trace blobs will be removed." %(
                len(blobs)
            ))
            db.pushAutoCommit(False)
            for b in blobs:
                b.traces = None
            db.popAutoCommit()
            db.commit()
        
        if(args.clean_useless_blobs):
            log.info("Deleting un-used traceblobs")
            blobs = db.getTraceSetBlobByTargetAndExperiment(
                target.id, experiment.id).all()
            to_remove = []

            for b in blobs:
                if(len(b.statisticTraces) == 0): 
                   to_remove.append(b)
                   
            log.info("Blobs to remove: %s"%",".join(
                [str(b.id) for b in to_remove])
            )
            db.pushAutoCommit(False)
            for b in to_remove:
                db._session.delete(b)
            db.popAutoCommit()
            db.commit()
            


    return 0


if(__name__=="__main__"):
    rcode = main()
    sys.exit(rcode)
