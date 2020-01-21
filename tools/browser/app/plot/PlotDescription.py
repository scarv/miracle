
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
        self._title         = title
        self._series        = series

        self._imgtype       = "png"
        self.width          = 12
        self.height         = 3
        self.separate_axes  = False

        self.set_y_limits   = False
        self.y_limit_min    = 0
        self.y_limit_max    = 0

        self._trim_info = {}

    def addTrimInfo(self, series, trim_info):
        self._trim_info[series] = trim_info

    def addSeries(self, s, trim_info = None):
        self._series.append(s)
        if(trim_info):
            self._trim_info[s] = trim_info

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

        plot_num = 1

        for s in self.series:

            if(self.separate_axes):
                ax  = fig.add_subplot(len(self.series),1,plot_num)
                ax.set_title("%s, %s, %s, %s" % (s.experiment.name, s.target_name,s.name , s.tracetype))
            else:
                ax  = fig.add_subplot(1,1,1)
            
            trace = s.trace

            if(s in self._trim_info):
                trim_start, trim_end = self._trim_info[s]
                if(trim_end == 0):
                    trim_end = 1
                trace = trace[trim_start:-trim_end]

            ax.plot(trace, linewidth=0.15)

            if(self.set_y_limits):
                ax.set_ylim(self.y_limit_min,self.y_limit_max)

            plot_num += 1

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

