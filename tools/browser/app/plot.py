
import io

from flask import Blueprint, flash, g, redirect, render_template
from flask import request, url_for, make_response

from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure
from matplotlib.dates import DateFormatter

from db import db_connect, db_close

bp = Blueprint('plot', __name__, url_prefix="/plot")


def getExperimentPayloadFromProgramBinary(pbin):
    if(pbin == None):
        return None
    if(pbin.disasm == None):
        return None

    lines = pbin.disasm.split("\n")

    tokeep= ""
    add_lines = False

    for l in lines:
        if(add_lines):
            tokeep += l +"\n"
            if(l.endswith("<experiment_payload_end>:")):
                return tokeep
        elif (l.endswith("<experiment_payload>:")):
            add_lines = True
            tokeep += l +"\n"


def makePlotFigure(
        straces,
        slabels=[],
        title="",
        xlabel="",
        ylabel="",
        ylines=[]
    ):
    """
    Given a list of satistic traces, create a plot of them.
    """
    fig = Figure(figsize=(10,5))

    for s in straces:

        ax  = fig.add_subplot(1,1,1)
        
        ax.plot(s, linewidth=0.15)

        if(xlabel and xlabel != ""):
            ax.set_xlabel(xlabel)

        if(ylabel and ylabel != ""):
            ax.set_ylabel(ylabel)

    for y in ylines:
        ax.axhline(y=y, xmin=0.0, xmax=1.0, color='r')
    
    if(title and title!=""):
        fig.suptitle(title,y=1.0)

    fig.tight_layout()

    return fig

    
def makePlotResponse(figure, imgtype="png"):
    """
    Return a Flask response object containing the rendered image.
    """
    sio     = io.BytesIO()

    canvas  = FigureCanvas(figure)

    canvas.print_png(sio)

    rsp     = make_response(sio.getvalue())

    rsp.headers["Content-Type"] = "image/%s" % imgtype

    return rsp


@bp.route("/stat-trace/<int:eid>/<int:tid>/<int:stid>")
def plot_statistic_trace(eid, tid, stid):
    """
    Render a the plot.html template for viewing a single statistic trace.
    """

    db          = db_connect()
    pbin        = None
    disasm      = None

    target      = db.getTargetById(tid)
    experiment  = db.getExperimentById(eid)

    pbin        = db.getProgramBinaryByTargetAndExperiment(
        target.id,
        experiment.id
    )
    
    disasm      = getExperimentPayloadFromProgramBinary(pbin)
    
    trace       = db.getStatisticTraceById(stid)
    
    template = render_template (
        "plot.html"             ,
        plotType    = str(trace.stat_type),
        target      = target    ,
        experiment  = experiment,
        stid        = trace.id  ,
        strace      = trace     ,
        pbin        = pbin      ,
        disasm      = disasm
    )

    db_close()

    return template


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
    pbin        = db.getProgramBinaryByTargetAndExperiment(
        target.id,
        experiment.id
    )
    
    disasm      = getExperimentPayloadFromProgramBinary(pbin)

    template = render_template (
        "plot.html"             ,
        plotType    = "TTest"   ,
        ttest       = ttest     ,
        target      = target    ,
        experiment  = experiment,
        stid        = stid      ,
        pbin        = pbin      ,
        disasm      = disasm
    )

    db_close()

    return template


@bp.route("/corrolation/<int:tid>")
def plot_view_corrolation_statistic(tid):
    """
    Render a the plot.html template for viewing a single corrolation-statistic
    trace.
    """

    db          = db_connect()

    corr        = db.getCorrolationTraceById(tid)
    target      = corr.target
    experiment  = corr.experiment
    stid        = corr.statisticTraceid
    pbin        = db.getProgramBinaryByTargetAndExperiment(
        target.id,
        experiment.id
    )

    disasm      = getExperimentPayloadFromProgramBinary(pbin)

    template = render_template (
        "plot.html"             ,
        plotType    = "Corrolation" ,
        corr        = corr      ,
        target      = target    ,
        experiment  = experiment,
        stid        = stid      ,
        pbin        = pbin      ,
        disasm      = disasm
    )

    db_close()

    return template


@bp.route("/render/statistic-trace/<int:tid>")
def render_statistic_trace(tid):
    """
    Render a single statistic trace using matplotlib.
    """

    db          = db_connect()

    strace      = db.getStatisticTraceById(tid)
    nptrace     = strace.getValuesAsNdArray()

    tgtId       = request.args.get("tgtid",None)
    expId       = request.args.get("eid",None)
    ttestId     = request.args.get("ttid",None)
    corrId      = request.args.get("corrId",None)

    title       = ""
    xlabel      = "Trace Sample"
    ylabel      = ""
    ylines      = []

    if(ttestId):
        ttest  = db.getTTraceSetsById(ttestId)
        title += "TTest: " + str(ttest.parameterDict) + " "
        ylabel = "T-Statistic Value"
        ylines.append(4.5)
        ylines.append(-4.5)
    
    if(corrId):
        corr   = db.getCorrolationTraceById(corrId)
        title += corr.corrType + ": " + ttest.randomTraceSet.parameters + " "

    if(expId):
        title += db.getExperimentById(expId).fullname+" "

    if(tgtId):
        title += db.getTargetById(tgtId).name+" "

    figure      = makePlotFigure(
        [nptrace],[],title, xlabel=xlabel, ylabel=ylabel, ylines=ylines
    )

    rsp         = makePlotResponse(figure)

    db_close()
    
    return rsp

