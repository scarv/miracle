#!/usr/bin/python3

"""
Toolscript for orchestrating trace set capture.
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

def connectToBackend(path, backend):
    """
    Returns an appropriate instance of a database backend based on
    the supplied path and backend parameters.
    """
    if(backend == "sqlite"):
        return ldb.backend.SQLiteBackend("sqlite:///"+path)
    else:
        raise Exception("Unknown backend '%s'" % backend)

def commandCapture(args, ef, db):
    """
    Runs a data capture for the supplied experiment and device.
    """
    log.info("Running capture for %s/%s" % (
        ef.EXPERIMENT_CATAGORY, ef.EXPERIMENT_NAME))

    ef.runCapture(args, db, scass)


def buildArgParser():
    """
    Return the ArgumentParser object used to parse command line arguments
    to the CLI app.
    """
    parser      = argparse.ArgumentParser()

    parser.add_argument("experiment", type=str,
        help="Path to experiment directory containing a experiment_flow.py script")
    
    parser.add_argument("device", type=str,
        help="Name of the device to run a data capture for")

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
    # Capture trace data subparser
    parser_capture = subparsers.add_parser("capture",
        help="Run a new capture flow for the given experiment")
    
    parser_capture.set_defaults(func=commandCapture)

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

    sys.path.append(os.path.expandvars(args.experiment))

    import ExperimentFlow as ef

    db = connectToBackend(args.dbpath, args.backend)

    result = args.func(args, ef, db)

    return result


if(__name__=="__main__"):
    rcode = main()
    sys.exit(rcode)
