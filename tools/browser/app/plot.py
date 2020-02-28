
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from db import db_connect, db_close

bp = Blueprint('plot', __name__, url_prefix="/plot")

@bp.route("/ttrace/<int:tid>")
def plot_view_tstatistic(tid):
    """
    Render a the plot.html template for viewing a single t-statistic
    trace.
    """

    db          = db_connect()

    ttest       = db.getTTraceSetsById(tid)
    target      = ttest.target
    experiment  = ttest.experiment
    stid        = ttest.ttraceId

    template = render_template (
        "plot.html"             ,
        plotType    = "TTest"   ,
        ttest       = ttest     ,
        target      = target    ,
        experiment  = experiment,
        stid        = stid
    )

    db_close()

    return template


@bp.route("/render/statistic-trace/<int:tid>")
def render_statistic_trace(tid):
    """
    Render a single statistic trace using matplotlib.
    """

    db          = db_connect()

    db_close()
