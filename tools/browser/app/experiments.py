
import os
import logging  as log

import configparser

from flask      import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from db import db_connect, db_close

bp          = Blueprint('experiments', __name__, url_prefix = "/experiments")

@bp.route("/")
def list_experiments():
    """
    Shows the page which lists all of the available target platforms.
    """
    db = db_connect()
    
    experiments = db.getAllExperiments()

    template = render_template(
        "experiments/list.html",
        experiments = experiments 
    )

    db_close()

    return template


@bp.route("/<int:id>")
def show_experiment(id):
    """
    Render page showing all information on a particular experiment.
    """
    db = db_connect()
    
    experiment  = db.getExperimentById(id)
    targets     = db.getTargetsByExperiment(experiment.id)

    template = render_template(
        "experiments/show.html" ,
        targets    = targets    ,
        experiment = experiment 
    )

    db_close()

    return template


@bp.route("/<int:eid>/<int:tid>")
def show_results(eid,tid):
    """
    Render page showing experiment results for a particular target and
    experiment combination.
    """
    db = db_connect()
    
    experiment = db.getExperimentById(eid)
    target     = db.getTargetById(tid)

    ttests     = db.getTTraceSetsByTargetAndExperiment(
        target.id, experiment.id
    )

    corrs      = db.getCorrolationTraceByTargetAndExperiment (
        target.id, experiment.id
    )

    template = render_template(
        "experiments/results.html"  ,
        target     = target         ,
        experiment = experiment     ,
        ttests     = ttests         ,
        corrs      = corrs
    )

    db_close()

    return template

