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

from CaptureInterface import CaptureInterface

def connectToBackend(path, backend):
    """
    Returns an appropriate instance of a database backend based on
    the supplied path and backend parameters.
    """
    if(backend == "sqlite"):
        return ldb.backend.SQLiteBackend("sqlite:///"+path)
    else:
        raise Exception("Unknown backend '%s'" % backend)


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

    experiment_dir = os.path.expandvars(args.experiment)
    module_file    = os.path.join(experiment_dir, "ExperimentFlow.py")

    if(not os.path.isdir(experiment_dir)):
        
        log.error("Experiment source directory '%s' does not exist." % (
            experiment_dir
        ))

        log.error("Is the 'experiment' command line argument ('%s') correct?" %
            args.experiment
        )

        return 1

    elif(not os.path.isfile(module_file)):

        log.error("Cannot find experiment flow module '%s'" %(
            module_file
        ))

        return 1

    sys.path.append(experiment_dir)

    import ExperimentFlow as ef

    db = connectToBackend(args.dbpath, args.backend)

    result = args.func(args, ef, db)

    return result


if(__name__=="__main__"):
    rcode = main()
    sys.exit(rcode)
