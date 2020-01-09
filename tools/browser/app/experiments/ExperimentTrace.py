
import os
import numpy as np

class ExperimentTrace:
    """
    Information on a single "statistic trace"
    """

    def __init__(self, path):
        """
        Create a new ExperimentTrace object
        """

        self._filepath  = path
        self._name      = os.path.basename(path)
        self._tracetype = "other"

        if(self._name.startswith("avg-trace")):
            self._tracetype = "avg"
        elif(self._name.startswith("cpa-hw")):
            self._tracetype = "cpa-hw"
        elif(self._name.startswith("cpa-hd")):
            self._tracetype = "cpa-hd"
        elif(self._name.startswith("max-trace")):
            self._tracetype = "max"
        elif(self._name.startswith("min-trace")):
            self._tracetype = "min"
        elif(self._name.startswith("rng-trace")):
            self._tracetype = "rng"
        elif(self._name.startswith("std-trace")):
            self._tracetype = "std"
        elif(self._name.startswith("ttrace")):
            self._tracetype = "ttrace"
        else:
            self._tracetype = "other"

        self._trace = np.load(self._filepath)

    @property
    def tracetype(self):
        return self._tracetype

    @property
    def name(self):
        return self._name

    @property
    def trace(self):
        return self._trace

    @property
    def filepath(self):
        return self._filepath

    
    def __lt__(self, other):
        """So we can sort things by trace name"""
        return self.name < other.name

