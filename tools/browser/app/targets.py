
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

bp = Blueprint('targets', __name__)

@bp.route("/targets")
def targets():

    return render_template("targets.html")
