
import os
import logging  as log

import configparser

from flask      import (
    Blueprint, flash, g, redirect, render_template, request, url_for,
    make_response
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

    pbin       = db.getProgramBinaryByTargetAndExperiment(
        target.id, experiment.id
    )

    template = render_template(
        "experiments/results.html"  ,
        target     = target         ,
        experiment = experiment     ,
        ttests     = ttests         ,
        corrs      = corrs          ,
        pbin       = pbin
    )

    db_close()

    return template

@bp.route("/download/binary/<int:pid>")
def download_binary(pid):
    """
    Download a program binary.
    """

    db = db_connect()

    pbin = db.getProgramBinaryById(pid)

    rsp = make_response(pbin.binary)
    rsp.headers.set("Content-Type","application/octet-stream")
    rsp.headers.set("Content-Disposition","attachment",
        filename = "%s-%s-program.elf" % (
            pbin.target.name, pbin.experiment.name
        )
    )

    db_close()

    return rsp


@bp.route("/download/disassembly/<int:pid>")
def download_disassembly(pid):
    """
    Download a program disassembly.
    """

    db = db_connect()

    pbin = db.getProgramBinaryById(pid)

    rsp = make_response(pbin.disasm)
    rsp.headers.set("Content-Type","text/plain")
    rsp.headers.set("Content-Disposition","attachment",
        filename = "%s-%s-program.dis" % (
            pbin.target.name, pbin.experiment.name
        )
    )

    db_close()

    return rsp
