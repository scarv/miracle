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

import numpy as np

sys.path.append(os.path.expandvars("$UAS_ROOT/tools/database"))
sys.path.append(os.path.expandvars("$UAS_ROOT/external/fw-acquisition"))

import ldb
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

    log.info("Loaded experiment module: '%s'" % experiment_path)

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


def getExperiments(db, experimentNames):
    """
    Return a list of ldb.records.Experiment objects based on the supplied
    names. If the supplied list is None, return all experiments.

    Returns None if one of the Experiment names does not exist in the database.
    """

    if(experimentNames == None):
        return db.getAllExperiments()

    tr = []
    
    for ename in experimentNames:
        
        catagory,name = ename.split("/")
        exp = db.getExperimentByCatagoryAndName(catagory, name)

        if(exp == None):
            
            log.error("No Experiment with catagory '%s' and name '%s' in database."%(catagory, name))
            
            return None

        else:

            tr.append(exp)

    return tr


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

    parser.add_argument("--experiments", type=str, nargs="+",
        help = "Name of the experiments to run the analysis for.")

    parser.add_argument("--targets", type=str, nargs="+",
        help = "Name of the target devices to run the analysis for.")

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

    experiment_set  = getExperiments(db, args.experiments)

    if(experiment_set == None):
        return 1


    for experiment in experiment_set:
        
        esubpath= "%s/%s" % (experiment.catagory, experiment.name)
        epath   = os.path.join(args.experiment_base_path, esubpath)

        emod = loadExperimentModule(epath)

        for target in target_set:

            log.info("Analysing %s/%s for %s" % (
                experiment.catagory, experiment.name, target.name))

            aif = AnalysisInterface(
                db, target, experiment
            )

            if(hasattr(emod, "runAnalysis")):
                emod.runAnalysis(aif)
            else:
                aif.runDefaultAnalysis()

    return 0


if(__name__=="__main__"):
    rcode = main()
    sys.exit(rcode)
