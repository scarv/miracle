
from .PlotDescription import PlotDescription

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

bp = Blueprint('plot', __name__, url_prefix="/plot")


@bp.route("/single-trace/<string:catagory>/<string:experiment_name>/<string:target_name>/<string:trace_name>")
def plot_single_trace(catagory,experiment_name, target_name, trace_name):
    """
    Plot a single trace and return it as an image.
    """
    experiment_name = catagory+"/"+experiment_name
    experiment      = bp.experiments[experiment_name]
    results         = experiment.getResultsForTarget(target_name)
    trace           = results.getTraceByName(trace_name)

    title           = "%s - %s - %s" % (
                        experiment_name, target_name, trace_name
                    )

    pd = PlotDescription(title=title,series=[trace])

    return pd.makePlotResponse()


@bp.route("/compare-trace/<string:catagory>/<string:experiment_name>/<string:target1>/<string:target2>/<string:trace_name>")
def compare_trace(catagory,experiment_name, target1, target2,trace_name):
    """

    """

