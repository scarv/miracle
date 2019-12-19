
import os

import yaml

from flask import (
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

    def fromYAML(filepath):
        """
        Given the supplied filepath, parse it as YAML and
        construct a target definition.
        """
        db = None
        
        with open (filepath,"r") as fh:
            db = yaml.load(fh, Loader=yaml.BaseLoader)

        tr = TargetDevice(db["name"])
        tr.type_implementation          = db["type"]["implementation"]
        tr.type_device_name             = db["type"]["device_name"]
        tr.type_device_link             = db["type"]["device_link"]
        tr.type_device_manufacturer_name= db["type"]["device_manufacturer_name"]
        tr.type_device_manufacturer_link= db["type"]["device_manufacturer_link"]
        tr.type_board_name              = db["type"]["board_name"]
        tr.type_board_link              = db["type"]["board_link"]
        tr.type_board_manufacturer_name = db["type"]["board_manufacturer_name"]
        tr.type_board_manufacturer_link = db["type"]["board_manufacturer_link"]
        tr.cpu_name                     = db["cpu"]["name"]
        tr.cpu_link                     = db["cpu"]["link"]
        tr.cpu_arch_name                = db["cpu"]["arch_name"]
        tr.cpu_arch_link                = db["cpu"]["arch_link"]
        tr.cpu_pipeline_depth           = db["cpu"]["pipeline_depth"]
        tr.cpu_manufacturer_name        = db["cpu"]["manufacturer_name"]
        tr.cpu_manufacturer_link        = db["cpu"]["manufacturer_link"]

        return tr


def discoverTargets():
    """
    Called once at app startup. Responsible for building the collection
    of target devices which live inside the blueprint.
    """
    print("Discovering target devices in %s" % targets_dir)

    for filename in os.listdir(targets_dir):
        fullpath = os.path.join(targets_dir, filename)
        if(os.path.isfile(fullpath) and filename.endswith(".yaml")):

            device = TargetDevice.fromYAML(fullpath)
            bp.target_devices[device.name] = device

            print("- %s" % device.name)


@bp.route("/targets")
def list_targets():
    """
    Shows the page which lists all of the available target platforms.
    """
    return render_template("targets.html", targets=bp.target_devices)

@bp.route("/target/<string:target_name>")
def show_target(target_name):
    """
    Renders the page which shows all information on a particular target
    and which experiment data is available for it.
    """
    tgt = bp.target_devices[target_name]

    return render_template("show_target.html", target=tgt)

#
# Call any one-time startup functions.
if(__name__ != "__main__"):
    discoverTargets()
