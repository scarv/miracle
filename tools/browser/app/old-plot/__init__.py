
from .PlotDescription import PlotDescription

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

bp = Blueprint('plot', __name__, url_prefix="/plot")

bp.requested_plots = {}
bp.plot_counter    = 0

def add_nocache_headers(r):
    """
    Add headers to both force latest IE rendering engine or Chrome Frame,
    and also to cache the rendered page for 10 minutes.
    """
    r.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    r.headers["Pragma"] = "no-cache"
    r.headers["Expires"] = "0"
    r.headers['Cache-Control'] = 'public, max-age=0'
    return r

@bp.route("/view-single-trace/<string:catagory>/<string:experiment_name>/<string:target_name>/<string:trace_name>")
def view_single_trace(catagory,experiment_name, target_name, trace_name):
    """
    Plot a single trace and return it as an image.
    """
    experiment_name = catagory+"/"+experiment_name
    experiment      = bp.experiments[experiment_name]
    results         = experiment.getResultsForTarget(target_name)
    trace           = results.getTraceByName(trace_name)

    return render_template("view-plot.html",
        experiment  = experiment,
        target      = bp.targets[target_name],
        trace       = trace
    )

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

    pd              = PlotDescription(title=title,series=[trace])
    pd.width        = 9

    return pd.makePlotResponse()

@bp.route("/multi-plot/request",methods=["POST"])
def plot_multiple_traces():
    """
    Plots multiple traces over one another.
    """
    
    key = bp.plot_counter + 1
    bp.plot_counter += 1

    pd = PlotDescription(title="",series = [])
    pd.width=10

    s1_experiment = bp.experiments[request.args["series1_exp"]]
    s1_results    = s1_experiment.getResultsForTarget(request.args["series1_dev"])
    s1_trace      = s1_results.getTraceByName(request.args["series1_trs"])
    s1_trace_trim_start = int(request.args.get("series1_trim_start",0))
    s1_trace_trim_end   = int(request.args.get("series1_trim_end"  ,0))

    s2_experiment = bp.experiments[request.args["series2_exp"]]
    s2_results    = s2_experiment.getResultsForTarget(request.args["series2_dev"])
    s2_trace      = s2_results.getTraceByName(request.args["series2_trs"])
    s2_trace_trim_start = int(request.args.get("series2_trim_start",0))
    s2_trace_trim_end   = int(request.args.get("series2_trim_end"  ,0))

    if(request.args.get("sep_axes","false") == "false"):
        pd.separate_axes = False
    else:
        pd.separate_axes = True

    pd.addSeries(s1_trace,trim_info=(s1_trace_trim_start,s1_trace_trim_end))
    pd.addSeries(s2_trace,trim_info=(s2_trace_trim_start,s2_trace_trim_end))

    if(pd.separate_axes):
        pd.height = 3*len(pd.series)

    bp.requested_plots[key] = pd

    return "%s" % key

@bp.route("/multi-plot/get")
def get_requested_plot():

    imgid = int(request.args["imgid"])
    
    tr = bp.requested_plots[imgid]
    del bp.requested_plots[imgid]

    rsp = tr.makePlotResponse()

    rsp = add_nocache_headers(rsp)

    return rsp


@bp.route("/compare-trace/<string:catagory>/<string:experiment_name>/<string:target1>/<string:trace_name>")
def compare_trace(catagory,experiment_name, target1, trace_name):
    """
    The page for doing trace comparisons.
    """
    
    experiment_name = catagory+"/"+experiment_name
    
    return render_template(
        "compare-traces.html",
        experiments     = bp.experiments,
        targets         = bp.targets,
        fix_experiment  = bp.experiments[experiment_name],
        fix_target1     = target1,
        fix_trace1      = trace_name
    )

@bp.route("/compare-trace")
def general_compare_trace():
    """
    The page for doing trace comparisons.
    """

    return render_template(
        "compare-traces.html",
        experiments     = bp.experiments,
        targets         = bp.targets
    )

