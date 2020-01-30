
import os
import logging as log

import markdown

from .ExperimentResultsSet import ExperimentResultsSet

def _renderCodeAsHTML(src,uid):
    lines = src.split("\n")
    for i in range(0,len(lines)):
        lid = "%s-%d" % (uid, i)
        newline = "<a href=\"#%s\" name=\"%s\">%03d</a>: %s" % (
            lid,lid,i,lines[i]
        )
        lines[i] = newline
    tr = "<pre>" + "\n".join(lines) + "</pre>"
    return tr

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

        self._documentation = None
        self._html_documentation = None

        self._experiment_kernels = {}

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


    def discoverSourceAndDocs(self, srcdir):
        """
        Tries to find the experiment README document and architecture specific
        source code from the uarch-leakage source repo.
        As opposed to looking in results_dir.
        Returns True iff the right README.md file is found.
        """

        # Try to find the readme. Don't try very hard...
        path = os.path.join(srcdir,self.name,"README.md")
        if(os.path.exists(path)):
            with open(path,"r") as fh:
                self._documentation = fh.read()
            self._html_documentation = markdown.markdown(self._documentation)
        
        # Get all of the architecture specific experiment files.
        experiment_kernels_dir = os.path.join(srcdir,self.name,"arch")
        if(os.path.isdir(experiment_kernels_dir)):
            possibles = os.listdir(experiment_kernels_dir)
            for possible in possibles:
                if(possible.endswith(".S")):
                    path = os.path.join(experiment_kernels_dir,possible)
                    arch = possible.partition(".")[0]
                    with open(path,"r") as fh:
                        self._experiment_kernels[arch] = fh.read()

    def getResultsForTarget(self, target_name):
        """
        Returns an ExperimentResultsSet object representing the results
        of this experiment for the given target, or None if no such
        results are present.
        """
        return self._targets.get(target_name, None)


    def getRenderedKernelCodeForArch(self, arch,uid):
        """
        Return the un-compiled assembly code which corresponds to this
        experiment for a given ISA.
        Returns False if no such architecture listing exists, or
        a string of the source code file contents if not.
        """
        if(arch in self._experiment_kernels):
            return _renderCodeAsHTML(self._experiment_kernels[arch],uid)
        else:
            return False

    
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
    def documentation(self):
        """Contents of the experiment markdown documentation"""
        return self._documentation

    @property
    def html_documentation(self):
        """
        Contents of the experiment markdown documentation, converted to HTML
        """
        return self._html_documentation
    
    @property
    def results_dir(self):
        return self._results_dir
