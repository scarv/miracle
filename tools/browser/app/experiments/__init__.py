
import os
import logging as log

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from .ExperimentInfo import ExperimentInfo

bp = Blueprint('experiments', __name__)

# Canonical list of experiments available for analysis
# Keys are strings, the experiment name. Values are ExperimentInfo instances.
bp.experiments = {}

# Canonical list of experiment catagories
bp.experiment_catagories = set([])

def discoverExperimentsInDirectory(dirname):
    """
    Add all subfolders of `dirname` as new experiments to the canoical
    experiments list.
    """
    
    log.info("Discovering experiments in: '%s'" % dirname)

    catagory    = os.path.basename(dirname)
    subdirs     = [
        d for d in os.listdir(dirname) 
            if os.path.isdir(os.path.join(dirname,d))
    ]

    for d in subdirs:
        results_dir     = os.path.join(dirname,d)
        experiment_name = catagory+"/"+d

        einfo           = ExperimentInfo(
            experiment_name, results_dir, catagory = catagory
        )

        bp.experiment_catagories.add(catagory)

        if(not experiment_name in bp.experiments):
            bp.experiments[experiment_name] = einfo
            log.info("Discovered Experiment: '%s'" % experiment_name)
        else:
            log.error("Duplicate Experiment Name: '%s'" % experiment_name)


@bp.route("/experiments")
def experiments_list():
    return render_template(
        "experiments.html",
        experiments = bp.experiments,
        catagories  = bp.experiment_catagories
    )

@bp.route("/experiments/<string:catagory>/<string:experiment_name>")
def experiment_landing_page(catagory,experiment_name):
    return render_template(
        "experiment-landing.html",
        experiment = bp.experiments[catagory+"/"+experiment_name]
    )

# Call any one-time startup functions
if(__name__ != "__main__"):
    pass

