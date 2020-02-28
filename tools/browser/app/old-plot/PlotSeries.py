
from ..experiments import ExperimentTrace

class PlotSeries(object):
    """
    Describes a single data series / line / bar on a graph
    """

    def __init__(self, trace):
        
        assert(instanceof(trace, ExperimentTrace))
        self._trace = trace


    @property
    def trace(self):
        return self.trace
