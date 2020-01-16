
from io import BytesIO

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for,
    make_response
)

from    matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas

from . import memory_bus_width_plots

bp = Blueprint('reports', __name__, url_prefix="/reports")

def makePlotResponse(fig):
    """
    Return a Flask response object containing the rendered image.
    """
    sio     = BytesIO()
    canvas  = FigureCanvas(fig)
    canvas.print_png(sio)
    rsp     = make_response(sio.getvalue())
    rsp.headers["Content-Type"] = "image/png"
    return rsp

@bp.route("/")
def experiments_list():
    return render_template(
        "reports-landing.html",
    )

@bp.route("/memory-bus-widths")
def memory_bus_widths():
    """
    Render the memory bus widths report.
    """
    selected_target = request.args.get("target",None)

    if(selected_target):
        selected_target = bp.targets[selected_target]

    return render_template(
        "reports-memory-bus-widths.html",
        targets = bp.targets,
        target  = selected_target
    )

@bp.route("/memory-bus-widths/plot/<string:width>/<string:target_name>")
def memory_bus_widths_plot_bytes(width,target_name):
    """
    Render the plot for the load bytes experiment.
    """
    target      = bp.targets[target_name]
    experiment  = bp.experiments["memory-bus/bus-width-ld-"+width]
    results     = experiment.getResultsForTarget(target.target_name)

    hw_traces   = results.getTracesOfType("cpa-hw")

    fig         = memory_bus_width_plots.plot_bytes(
        hw_traces,"Hamming Weight Leakage"
    )
    rsp         = makePlotResponse(fig)
    return        rsp


