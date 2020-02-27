
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

    template = render_template(
        "targets/target-list.html",
        targets = targets,
        devices = devices,
        cores   = cores
    )

    db_close()

    return template

