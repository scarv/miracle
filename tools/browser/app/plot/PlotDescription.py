
from    io                  import  BytesIO

from    flask               import  make_response

from    matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from    matplotlib.figure import Figure
from    matplotlib.dates import DateFormatter

class PlotDescription(object):
    """
    Describes how to make a graph plot.
    """

    def __init__(self, title="", series = []):
        self._title     = title
        self._series    = series

        self._imgtype   = "png"
        self.width      = 12
        self.height     = 3

    @property
    def series(self):
        return self._series
    
    @property
    def imgtype(self):
        return self._imgtype
    
    @property
    def title(self):
        return self._title
    

    def makePlot(self):
        """
        Return the matplotlib figure of the plot.
        """

        fig = Figure(figsize=(self.width,self.height))
        ax  = fig.add_subplot(111)

        for s in self.series:
            ax.plot(s.trace, linewidth=0.15)

        fig.tight_layout()
        
        fig.suptitle(self.title)

        return fig


    def makePlotResponse(self):
        """
        Return a Flask response object containing the rendered image.
        """
        fig     = self.makePlot()
        sio     = BytesIO()

        canvas  = FigureCanvas(fig)

        canvas.print_png(sio)

        rsp     = make_response(sio.getvalue())

        rsp.headers["Content-Type"] = "image/%s" % self.imgtype

        return rsp

