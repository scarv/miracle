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

def loadDeviceConfig(path):
    """
    Takes a file path to a device config file and returns the loaded
    configuration or None if it failed.
    """
    if(os.path.isfile(path)):
        cfg = configparser.ConfigParser()
        cfg.read(path)
        return cfg
    else:
        log.error("Device config '%s' is not a file." % path)
        return None

def loadScope(config_path):
    """
    Create a scope class instance based on the configuration file path
    supplied as a parameter.
    return an instance of scass.scope.Scope or None.
    """
    return scass.scope.fromConfig(config_path)


def commandCapture(args, ef, db):
    """
    Runs a data capture for the supplied experiment and device.
    """

    log.info("Experiment working directory: '%s'" % args.work_dir)
    if(not os.path.isdir(args.work_dir)):
        os.mkdir(args.work_dir)

    device_config = loadDeviceConfig(args.device)

    if(device_config== None):
        return 1

    target_config = device_config["TARGET"]

    target_name = target_config["NAME"]
    target_baud = int(target_config["UART_BAUD"])

    if(args.baud):
        target_baud = args.baud

    log.info("Connecting to target %s on %s @ %d" % (
        target_name, args.port, target_baud
    ))

    target_comms = scass.comms.Target(args.port, target_baud)

    try:
        tname   = target_comms.doGetExperiementName()
        log.info("Target experiment name: '%s'" % tname)
        tcatagory, tname = tname.split("/")

        if(tcatagory != ef.EXPERIMENT_CATAGORY):
            log.error("Experiment catagory '%s' doesn't match target experiment catagory: '%s'" % (ef.EXPERIMENT_CATAGORY, tcatagory))
            return 1

        if(tname != ef.EXPERIMENT_NAME):
            log.error("Experiment name '%s' doesn't match target experiment name: '%s'" % (ef.EXPERIMENT_NAME, tname))
            return 1

    except Exception as e:
        log.error(e)
        return 1

    log.info("Connecting to scope...")
    scope = loadScope(args.scope_config)

    log.info("Scope power channel: '%s'" % args.scope_power_channel)

    capif = CaptureInterface(
        args, scope, target_name, target_comms, db, args.work_dir
    )

    log.info("Initialising experiment...")
    assert(target_comms.doInitExperiment()),"Failed experiment initialisation"

    trigger_window_size =  scass.scope.findTriggerWindowSize(
        scope, target_comms, scope.getChannel(args.scope_power_channel)
    )
    log.info("Trigger window size: %d" % trigger_window_size)

    capif.trigger_window_size = trigger_window_size
    capif.scope_power_channel = scope.getChannel(args.scope_power_channel)

    log.info("Running capture for %s/%s on target %s" % (
        ef.EXPERIMENT_CATAGORY, ef.EXPERIMENT_NAME, target_name))

    result = ef.runCapture(capif)

    log.info("Capture complete for %s/%s on target %s" % (
        ef.EXPERIMENT_CATAGORY, ef.EXPERIMENT_NAME, target_name))

    return result


def buildArgParser():
    """
    Return the ArgumentParser object used to parse command line arguments
    to the CLI app.
    """
    parser      = argparse.ArgumentParser()

    parser.add_argument("experiment", type=str,
        help="Path to experiment directory containing a experiment_flow.py script")
    
    parser.add_argument("device", type=str,
        help="Path to the device config to run the capture for.")

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
    # Capture trace data subparser
    parser_capture = subparsers.add_parser("capture",
        help="Run a new capture flow for the given experiment")
    
    parser_capture.set_defaults(func=commandCapture)
    
    parser_capture.add_argument("scope_config", type=str,
        help="Path to the scope config to run the capture for.")
    
    parser_capture.add_argument("port", type=str,
        help="Serial port to connect to the device on.")
    
    parser_capture.add_argument("work_dir", type=str,
        help="Where to put captured data files")
    
    parser_capture.add_argument("--baud",type=int,
        help="Override default baud rate of target device as specified the <device> argument config file")

    parser_capture.add_argument("--ttest-traces", default=5000, type=int,
        help="How many TTest traces to capture")
    
    parser_capture.add_argument("--scope-power-channel", type=str,
        default="B",help="Name of scope channel we measure power on.")
    

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

    sys.path.append(os.path.expandvars(args.experiment))

    import ExperimentFlow as ef

    db = connectToBackend(args.dbpath, args.backend)

    result = args.func(args, ef, db)

    return result


if(__name__=="__main__"):
    rcode = main()
    sys.exit(rcode)
