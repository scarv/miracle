
import os
import logging as log
import io

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for,
    send_file
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
        experiment = bp.experiments[catagory+"/"+experiment_name],
        targets    = bp.targets
    )

@bp.route("/experiments/<string:catagory>/<string:experiment_name>/<string:target_name>")
def experiment_results_page(catagory,experiment_name, target_name):
    experiment_name = catagory+"/"+experiment_name
    experiment      = bp.experiments[experiment_name]
    results         = experiment.getResultsForTarget(target_name)
    return render_template(
        "experiment-results.html",
        experiment = experiment,
        target     = bp.targets[target_name],
        results    = results
    )

@bp.route("/experiments/download-trace/<string:catagory>/<string:experiment_name>/<string:target_name>/<string:trace_name>")
def download_trace(catagory,experiment_name, target_name,trace_name):
    """
    Returns the *.npy trace file for download.
    """
    experiment_name = catagory+"/"+experiment_name
    experiment      = bp.experiments[experiment_name]
    results         = experiment.getResultsForTarget(target_name)
    trace           = results.getTraceByName(trace_name)

    if(trace == None):
        return "No such trace exists."
    else:
        name = "%s-%s-%s-%s" % (experiment.catagory,experiment.shortname,
            target_name,trace_name)
        return send_file(trace.filepath,attachment_filename=name)

@bp.route("/experiments/download-program/<string:catagory>/<string:experiment_name>/<string:target_name>")
def download_program(catagory,experiment_name, target_name):
    experiment_name = catagory+"/"+experiment_name
    experiment      = bp.experiments[experiment_name]
    results         = experiment.getResultsForTarget(target_name)

    fname = "%s-%s-%s-program.elf" % (catagory,experiment.shortname,target_name)
    return send_file(results.program_elf,as_attachment=True,
        attachment_filename=fname,mimetype="application")

@bp.route("/experiments/download-disassembly/<string:catagory>/<string:experiment_name>/<string:target_name>")
def download_disassembly(catagory,experiment_name, target_name):
    experiment_name = catagory+"/"+experiment_name
    experiment      = bp.experiments[experiment_name]
    results         = experiment.getResultsForTarget(target_name)
    
    fname = "%s-%s-%s-program.dis" % (catagory,experiment.shortname,target_name)
    return send_file(results.program_dis,as_attachment=True,
        attachment_filename=fname,mimetype="text/plain")
    

# Call any one-time startup functions
if(__name__ != "__main__"):
    pass

