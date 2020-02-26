
import os
import logging as log
import datetime

import ldb

from ldb.records import TraceSetBlob

import scass

class AnalysisInterface(object):
    """
    Stores everything needed to be passed to an ExperimentFlow module to
    perform analysis of experiment results..

    Acts as a middle layer providing all boilerplate code that the
    ExperimentFlow modules might need, including ttest analysis, database
    object insertion and so on.
    """

    def __init__(self, database, target, experiment, force=False):
        self.database       = database
        self.experiment     = experiment
        self.target         = target
        self.force          = force


    def runDefaultAnalysis(self):
        """
        Run the defualt set of analyses on the given experiment+target
        combination and place the results in the database.
        """

