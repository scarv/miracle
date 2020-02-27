
import os
import logging  as log

import configparser

from flask      import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from db import db_connect, db_close

bp          = Blueprint('targets', __name__, url_prefix = "/targets")

@bp.route("/")
def list_targets():
    """
    Shows the page which lists all of the available target platforms.
    """
    db = db_connect()
    
    targets  = db.getAllTargets()
    devices  = db.getAllDevices()
    cores    = db.getAllCores()
    boards   = db.getAllBoards()

    template = render_template(
        "targets/list.html",
        targets = targets,
        devices = devices,
        cores   = cores,
        boards  = boards
    )

    db_close()

    return template


@bp.route("/target/<int:id>")
def show_target(id):
    """
    Renders a page which lists all the information on a particular target.
    """
    db = db_connect()

    target = db.getTargetById(id)
    experiments = db.getExperimentsByTarget(target.id)
    
    template = render_template(
        "targets/target.html",
        target = target,
        experiments = experiments
    )

    db_close()

    return template


@bp.route("/board/<int:id>")
def show_board(id):
    """
    Renders a page which lists all the information on a particular board.
    """
    db = db_connect()

    board = db.getBoardById(id)
    targets = db.getTargetsByBoard(board.id)
    
    template = render_template(
        "targets/board.html",
        board = board,
        targets = targets
    )

    db_close()

    return template


@bp.route("/core/<int:id>")
def show_core(id):
    """
    Renders a page which lists all the information on a particular core.
    """
    db = db_connect()

    core = db.getCoreById(id)
    targets = db.getTargetsByCore(core.id)
    
    template = render_template(
        "targets/core.html",
        core = core,
        targets = targets
    )

    db_close()

    return template


@bp.route("/device/<int:id>")
def show_device(id):
    """
    Renders a page which lists all the information on a particular device.
    """
    db = db_connect()

    device = db.getDeviceById(id)
    targets = db.getTargetsByDevice(device.id)
    
    template = render_template(
        "targets/device.html",
        device = device,
        targets = targets
    )

    db_close()

    return template



