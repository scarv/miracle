
import os
import logging as log
import datetime

import ldb

from ldb.records import StatisticTrace

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


    def runTTestAnalyses(self, ttest):
        """
        Compute the T-Statistic trace for the supplied ttest object.
        If the trace already exists, it is not recomputed unless self.force
        is True
        """
        if(ttest.tStatisticTrace == None or self.force):

            fixed_traces  = ttest.fixedTraceSet.getTracesAsNdArray()
            random_traces = ttest.fixedTraceSet.getTracesAsNdArray()

            tt            = scass.ttest.TTest(fixed_traces, random_traces)

            if(ttest.tStatisticTrace == None):

                stat_trace  = StatisticTrace.fromTraceArray(
                    tt.ttrace,
                    ldb.records.StatTraceType.TTRACE
                )

                ttest.tStatisticTrace = stat_trace

            else:

                ttest.tStatisticTrace.setTraceValues(tt.ttrace)

            self.database.commit()

            log.info("Computed T-Statistic trace for TTest ID=%d" % (
                ttest.id
            ))



    def runDefaultAnalysis(self):
        """
        Run the defualt set of analyses on the given experiment+target
        combination and place the results in the database.
        """

        ttest_sets = self.database.getTTraceSetsByTargetAndExperiment(
            self.target.id, self.experiment.id
        )

        for ttest in ttest_sets:
            self.runTTestAnalyses(ttest)
