
import io

from flask import Blueprint, flash, g, redirect, render_template
from flask import request, url_for, make_response

from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure
from matplotlib.dates import DateFormatter

from db import db_connect, db_close

bp = Blueprint('plot', __name__, url_prefix="/plot")

def makePlotFigure(
        straces,
        slabels=[],
        title=""
    ):
    """
    Given a list of satistic traces, create a plot of them.
    """
    fig = Figure(figsize=(10,5))

    for s in straces:

        ax  = fig.add_subplot(1,1,1)
        
        ax.plot(s, linewidth=0.15)

    fig.tight_layout()
    
    if(title and title!=""):
        fig.suptitle(title)

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

    strace      = db.getStatisticTraceById(tid)
    nptrace     = strace.getValuesAsNdArray()

    figure      = makePlotFigure(
        [nptrace],[],""
    )

    rsp         = makePlotResponse(figure)

    db_close()
    
    return rsp
