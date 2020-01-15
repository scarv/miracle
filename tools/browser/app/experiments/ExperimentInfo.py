
import os

from .ExperimentResultsSet import ExperimentResultsSet

class ExperimentInfo:
    """
    Contains all relevent information on a single experiment.
    """

    def __init__(self, name, results_dir,catagory="none"):
        """
        Creates a new experiment info class, which then goes away and
        discovers as much information as it can about the experiment
        artifacts from the supplied results directory.
        """

        self._name          = name
        self._results_dir   = results_dir
        self._catagory      = catagory

        self._targets       = {}

        self.__discoverTargets()


    def __discoverTargets(self):
        """
        Called by init, used to discover which targets have results for
        this experiment.
        """
        
        for target_name in os.listdir(self.results_dir):
            if(os.path.isdir(os.path.join(self.results_dir,target_name))):
                results_set = ExperimentResultsSet(self, target_name)
                self._targets[target_name] = results_set


    def getResultsForTarget(self, target_name):
        """
        Returns an ExperimentResultsSet object representing the results
        of this experiment for the given target, or None if no such
        results are present.
        """
        return self._targets.get(target_name, None)

    
    @property
    def targetNames(self):
        """Return the names of targets this experiment has results for"""
        return self._targets.keys()

    @property
    def targets(self):
        return self._targets.values()

    @property
    def name(self):
        return self._name
    
    @property
    def shortname(self):
        return self._name.partition("/")[2]
    
    @property
    def catagory(self):
        return self._catagory
    
    @property
    def results_dir(self):
        return self._results_dir
