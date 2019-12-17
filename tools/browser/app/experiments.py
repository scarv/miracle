
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

bp = Blueprint('experiments', __name__)

@bp.route("/experiments")
def targets():

    return render_template("experiments.html")

