
import operator
from io import BytesIO

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for,
    make_response
)

from    matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas

from plot import PlotDescription

bp = Blueprint('reports', __name__, url_prefix="/reports")

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
    trace_type      = request.args.get("trace_type","ttrace")
    normalise_axes  = request.args.get("normalise_axes","true")

    if(selected_target):
        selected_target = bp.targets[selected_target]

    return render_template(
        "reports-memory-bus-widths.html",
        targets = bp.targets,
        target  = selected_target,
        trace_type = trace_type,
        normalise_axes = normalise_axes
    )

@bp.route("/memory-bus-widths/plot/<string:width>/<string:target_name>/<string:trace_type>/<string:normalise_axes>/<string:ldst>")
def memory_bus_widths_plot_bytes(width,target_name,trace_type,normalise_axes,ldst):
    """
    Render the plot for the load/store * experiment.
    where * is specified by width and width is one of bytes,halfword,word
    """
    target      = bp.targets[target_name]
    experiment  = bp.experiments["memory-bus/bus-width-"+ldst+"-"+width]
    results     = experiment.getResultsForTarget(target.target_name)

    hw_traces   = results.getTracesOfType(trace_type)
    hw_traces.sort(key=operator.attrgetter('name'))

    pd          = PlotDescription(series=hw_traces)

    pd.height   = 1.5*len(hw_traces)
    pd.width    = 8
    pd.separate_axes = True

    if(normalise_axes == "true" and trace_type == "cpa-hw"):
        pd.set_y_limits = True
        pd.y_limit_min  = 0.0
        pd.y_limit_max  = 1.0
    else:
        pd.set_y_limits = False

    rsp         = pd.makePlotResponse()

    return        rsp


@bp.route("/memory-access-hazards")
def memory_access_hazards():
    """
    Render the memory bus widths report.
    """
    selected_target = request.args.get("target",None)
    trace_type      = request.args.get("trace_type","ttrace")
    normalise_axes  = request.args.get("normalise_axes","true")

    if(selected_target):
        selected_target = bp.targets[selected_target]

    return render_template(
        "reports-memory-access-hazards.html",
        targets = bp.targets,
        target  = selected_target,
        trace_type = trace_type,
        normalise_axes = normalise_axes
    )

@bp.route("/memory-access-hazards/plot/<string:target_name>/<string:ename>")
def memory_access_hazards_plot(target_name, ename):
    target      = bp.targets[target_name]
    experiment  = bp.experiments["memory-bus/registers-implicit-"+ename]
    results     = experiment.getResultsForTarget(target.target_name)
    normalise_axes  = request.args.get("normalise_axes","true")
    trace_type      = request.args.get("trace_type","cpa-hd")

    hw_traces   = results.getTracesOfType(trace_type)
    hw_traces.sort(key=operator.attrgetter('name'))
    
    pd          = PlotDescription(series=hw_traces)

    pd.height   = 1.5*len(hw_traces)
    pd.width    = 8
    pd.separate_axes = True

    if(normalise_axes=="true"):
        pd.set_y_limits = True
        pd.y_limit_min  = 0.0
        pd.y_limit_max  = 1.0

    rsp         = pd.makePlotResponse()

    return        rsp


@bp.route("/pipeline-registers")
def pipeline_registers():
    """
    Render the pipeline registers widths report.
    """
    selected_target = request.args.get("target",None)
    trace_type      = request.args.get("trace_type","ttrace")
    normalise_axes  = request.args.get("normalise_axes","true")

    if(selected_target):
        selected_target = bp.targets[selected_target]

    return render_template(
        "reports-pipeline-registers.html",
        targets = bp.targets,
        target  = selected_target,
        trace_type = trace_type,
        normalise_axes = normalise_axes
    )

@bp.route("/pipeline-registers/plot/<string:target_name>/<string:ename>")
def pipeline_registers_plot(target_name, ename):
    target      = bp.targets[target_name]
    experiment_l= bp.experiments["pipeline/"+ename+"-lhs"]
    experiment_r= bp.experiments["pipeline/"+ename+"-rhs"]
    results_l   = experiment_l.getResultsForTarget(target.target_name)
    results_r   = experiment_r.getResultsForTarget(target.target_name)
    normalise_axes  = request.args.get("normalise_axes","true")
    trace_type      = request.args.get("trace_type","cpa-hd")
    
    hw_traces   = results_l.getTracesOfType(trace_type) + \
                  results_r.getTracesOfType(trace_type)
    hw_traces.sort(key=operator.attrgetter('name'))
    
    pd          = PlotDescription(series=hw_traces)

    pd.height   = 1.5*len(hw_traces)
    pd.width    = 8
    pd.separate_axes = True

    if(normalise_axes=="true"):
        pd.set_y_limits = True
        pd.y_limit_min  = 0.0
        pd.y_limit_max  = 1.0

    rsp         = pd.makePlotResponse()

    return        rsp


@bp.route("/speculation")
def speculation():
    """
    Render the speculative execution report.
    """
    selected_target = request.args.get("target",None)
    trace_type      = request.args.get("trace_type","ttrace")
    normalise_axes  = request.args.get("normalise_axes","true")

    if(selected_target):
        selected_target = bp.targets[selected_target]

    return render_template(
        "reports-speculation.html",
        targets = bp.targets,
        target  = selected_target,
        trace_type = trace_type,
        normalise_axes = normalise_axes
    )


@bp.route("/speculation/plot/<string:target_name>/<string:ename>")
def speculation_plot(target_name, ename):
    target      = bp.targets[target_name]
    experiment  = bp.experiments["speculation/"+ename]
    results     = experiment.getResultsForTarget(target.target_name)
    normalise_axes  = request.args.get("normalise_axes","true")
    trace_type      = request.args.get("trace_type","cpa-hd")
    
    hw_traces   = results.getTracesOfType(trace_type)
    hw_traces.sort(key=operator.attrgetter('name'))
    
    pd          = PlotDescription(series=hw_traces)

    pd.height   = 1.5*len(hw_traces)
    pd.width    = 8
    pd.separate_axes = False

    if(normalise_axes=="true"):
        pd.set_y_limits = True
        pd.y_limit_min  = 0.0
        pd.y_limit_max  = 1.0

    rsp         = pd.makePlotResponse()

    return        rsp


@bp.route("/rosita")
def rosita():
    """
    Render the rosita countermeasures report.
    """
    selected_target = request.args.get("target",None)
    trace_type      = request.args.get("trace_type","ttrace")
    normalise_axes  = request.args.get("normalise_axes","true")

    if(selected_target):
        selected_target = bp.targets[selected_target]

    return render_template(
        "reports-rosita.html",
        targets = bp.targets,
        target  = selected_target,
        trace_type = trace_type,
        normalise_axes = normalise_axes
    )


@bp.route("/rosita/plot/<string:target_name>/<string:ename>")
def rosita_plot(target_name, ename):
    target      = bp.targets[target_name]
    experiment  = bp.experiments["countermeasures/"+ename]
    results     = experiment.getResultsForTarget(target.target_name)
    normalise_axes  = request.args.get("normalise_axes","true")
    trace_type      = request.args.get("trace_type","cpa-hd")
    
    hw_traces   = results.getTracesOfType(trace_type)
    hw_traces.sort(key=operator.attrgetter('name'))
    
    pd          = PlotDescription(series=hw_traces)

    pd.height   = 1.5*len(hw_traces)
    pd.width    = 8
    pd.separate_axes = False

    if(normalise_axes=="true"):
        pd.set_y_limits = True
        pd.y_limit_min  = 0.0
        pd.y_limit_max  = 1.0

    rsp         = pd.makePlotResponse()

    return        rsp

