
import os
import numpy as np

class ExperimentTrace:
    """
    Information on a single "statistic trace"
    """

    def __init__(self, path, target_name, experiment):
        """
        Create a new ExperimentTrace object
        """

        self._filepath  = path
        self._name      = os.path.basename(path)
        self._tracetype = "other"
        self._target_name = target_name
        self._experiment= experiment

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
        """The name (without directory) of the trace file"""
        return self._name

    @property
    def target_name(self):
        """The name of the target device this trace belongs too"""
        return self._target_name

    @property
    def experiment(self):
        """The ExperimentInfo object this trace is associated with"""
        return self._experiment

    @property
    def trace(self):
        return self._trace

    @property
    def filepath(self):
        return self._filepath

    
    def __lt__(self, other):
        """So we can sort things by trace name"""
        return self.name < other.name

