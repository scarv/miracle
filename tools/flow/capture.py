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

sys.path.append(os.path.expandvars("$MIR_DB_REPO_HOME"))
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


def insertBinary(args, db, ef, device_config):
    """
    Insert a program binary and/or disassembly into the database.
    
    Must be done after the main capture function, otherwise there
    might not be an experiment in the database to associate the
    program binary with.
    """

    f_bin= None
    f_dis= None

    if(args.store_binary):
        log.info("- Binary     : %s" % args.store_binary)
        with open(args.store_binary,"rb") as fh:
            f_bin = fh.read()

    if(args.store_disasm):
        log.info("- Disassembly: %s" % args.store_disasm)
        with open(args.store_disasm,"r") as fh:
            f_dis = fh.read()

    tgt = db.getTargetByName(device_config["TARGET"]["NAME"])

    exp = db.getExperimentByCatagoryAndName(
        ef.EXPERIMENT_CATAGORY, ef.EXPERIMENT_NAME
    )

    assert(tgt != None),"Target should not be None"
    assert(exp != None),"Experiment should not be None"

    pbin= db.getProgramBinaryByTargetAndExperiment(tgt.id,exp.id)

    if(pbin == None):
        log.info("Inserting new program binary record.")

        pbin = ldb.records.ProgramBinary(
            binary = f_bin,
            disasm = f_dis,
            target = tgt,
            experiment = exp
        )

        db.insertProgramBinary(pbin)

    else:
        
        log.info("Updating existing program binary record.")
        
        pbin.binary = f_bin
        pbin.disasm = f_dis

    db.commit()


def commandCapture(args, ef, db, device_config):
    """
    Runs a data capture for the supplied experiment and device.
    """

    if(device_config== None):
        return 1

    target_config = device_config["TARGET"]

    target_name = target_config["NAME"]
    target_baud = int(target_config["UART_BAUD"])

    if(args.baud):
        if(target_baud != args.baud):
            log.warning("Target CFG baud rate does not match baud rate specified on command line.")
            log.warning("Defaulting to target device baud rate")
        else:
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

        current_cfg, clock_info = target_comms.doGetSysClkInfo()

        log.info("Clock sources:")
        for i,clk_cfg in enumerate(clock_info):
            lstr = "- "+str(clk_cfg)
            if(i == current_cfg):
                lstr+=(" [Current]")
            log.info(lstr)

    except Exception as e:
        log.error(e)
        return 1

    log.info("Connecting to scope...")
    scope = loadScope(args.scope_config)

    log.info("Scope power channel: '%s'" % args.scope_power_channel)

    capif = CaptureInterface(
        args, scope, target_name, target_comms, db
    )

    capif.skip_if_present = args.skip_if_present

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
    
    parser.set_defaults(func=commandCapture)

    parser.add_argument("experiment", type=str,
        help="Path to experiment directory containing a experiment_flow.py script")
    
    parser.add_argument("device", type=str,
        help="Path to the device config to run the capture for.")

    parser.add_argument("dbpath", type=str, 
        help="File-path of the database")
    
    parser.add_argument("scope_config", type=str,
        help="Path to the scope config to run the capture for.")
    
    parser.add_argument("port", type=str,
        help="Serial port to connect to the device on.")
    
    parser.add_argument("--backend", choices=["sqlite"],
        default="sqlite", help="Database Backend To Use")

    parser.add_argument("--verbose","-v",action="store_true",
        help="Turn on verbose logging.")

    parser.add_argument("--log", type=str,
        help = "Filepath to log too."
    )

    parser.add_argument("--store-binary", type=str,
        help="Store this binary file in the database associated with the experiment")
    
    parser.add_argument("--store-disasm", type=str,
        help="Store this disassembly file in the database associated with the experiment")
    
    parser.add_argument("--baud",type=int,
        help="Override default baud rate of target device as specified the <device> argument config file")

    parser.add_argument("--ttest-traces", default=5000, type=int,
        help="How many TTest traces to capture")
    
    parser.add_argument("--scope-power-channel", type=str,
        default="B",help="Name of scope channel we measure power on.")
    
    parser.add_argument("--skip-if-present",action="store_true",
        help="Skip trace collection if a matching traceset already exists in the database")

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

    device_config = loadDeviceConfig(args.device)

    result = args.func(args, ef, db, device_config)

    # Must be done after the main capture function, otherwise there
    # might not be an experiment in the database to associate the
    # program binary with.
    if(args.store_binary or args.store_disasm):
        log.info("Storing program binary in database.")
        insertBinary(args, db, ef, device_config)

    return result


if(__name__=="__main__"):
    rcode = main()
    sys.exit(rcode)
