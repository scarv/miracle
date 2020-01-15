
import os
import logging  as log

import configparser

from flask      import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

# Flask APP Blueprint
bp          = Blueprint('targets', __name__)

# Storage for all of the target device descriptions, keyed by device name.
bp.target_devices = {}

# Folder where the target device descriptions are kept.
targets_dir = os.path.abspath("app/targets/")

class TargetDevice:

    def __init__(self, name):
        
        self.name = name
        self.experiments = []

    def fromCFG(filepath):
        """
        Given the supplied filepath, parse it as YAML and
        construct a target definition.
        """
        db = None


        config = configparser.ConfigParser()
        config.read(filepath)
        
        tr = TargetDevice(config["TARGET"]["NAME"])

        tr.target_name                = config["TARGET"]["NAME"]
        tr.target_description         = config["TARGET"]["DESCRIPTION"]
        tr.target_implementation      = config["TARGET"]["IMPLEMENTATION"]

        tr.device_name                = config["DEVICE"]["NAME"]
        tr.device_link                = config["DEVICE"]["LINK"]
        tr.device_manufacturer_name   = config["DEVICE"]["MANUFACTURER_NAME"]
        tr.device_manufacturer_link   = config["DEVICE"]["MANUFACTURER_LINK"]

        tr.board_name                 = config["BOARD"]["NAME"]
        tr.board_link                 = config["BOARD"]["LINK"]
        tr.board_manufacturer_name    = config["BOARD"]["MANUFACTURER_NAME"]
        tr.board_manufacturer_link    = config["BOARD"]["MANUFACTURER_LINK"]

        tr.cpu_arch_name              = config["CPU"]["ARCH_NAME"]
        tr.cpu_arch_link              = config["CPU"]["ARCH_LINK"]
        tr.cpu_core_link              = config["CPU"]["CORE_LINK"]
        tr.cpu_core_name              = config["CPU"]["CORE_NAME"]
        tr.cpu_core_manufacturer_name = config["CPU"]["CORE_MANUFACTURER_NAME"]
        tr.cpu_core_manufacturer_link = config["CPU"]["CORE_MANUFACTURER_LINK"]
        tr.cpu_pipeline_depth         = config["CPU"]["PIPELINE_DEPTH"]

        return tr

    def discoverExperimentsForTarget(self, experiments):
        """
        Given a dictionary of ExperimentInfo, keyed by experiment name, build
        a list of experiments inside this TargetDevice instance of all
        experiments which have results pertaining to this device.
        """

        for ename in experiments:
            if(self.name in experiments[ename].targetNames):
                self.experiments.append(experiments[ename])


def discoverTargets():
    """
    Called once at app startup. Responsible for building the collection
    of target devices which live inside the blueprint.
    """
    log.info("Discovering target devices in %s" % targets_dir)

    for filename in os.listdir(targets_dir):
        fullpath = os.path.join(targets_dir, filename)
        if(os.path.isfile(fullpath) and filename.endswith(".cfg")):

            device = TargetDevice.fromCFG(fullpath)
            bp.target_devices[device.name] = device

            log.info("Discovered Target Device: %s" % device.name)


@bp.route("/targets")
def list_targets():
    """
    Shows the page which lists all of the available target platforms.
    """
    return render_template("targets.html", targets=bp.target_devices)

@bp.route("/target/<string:target_name>")
def target_landing_page(target_name):
    """
    Renders the page which shows all information on a particular target
    and which experiment data is available for it.
    """
    tgt = bp.target_devices[target_name]

    return render_template("target-landing.html", target=tgt)

#
# Call any one-time startup functions.
if(__name__ != "__main__"):
    discoverTargets()
