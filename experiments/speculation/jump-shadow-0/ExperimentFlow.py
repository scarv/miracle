
import os
import logging as log

EXPERIMENT_CATAGORY = "speculation"
EXPERIMENT_NAME     = "jump-shadow-0"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """
    return args.runAndInsertTTest (
            EXPERIMENT_CATAGORY ,
            EXPERIMENT_NAME     ,
            {}
        )

def runAnalysis(aif):
    """
    Run any experiment specific analysis.

    aif - AnalysisInterface instance
    """

    aif.runDefaultAnalysis()

    for ttest in aif.getTTestsForTargetAndExperiment():
        aif.runHammingDistanceAnalysis(ttest.randomTraceSet, "di1","di2")
        aif.runHammingDistanceAnalysis(ttest.randomTraceSet, "di2","di3")
        aif.runHammingDistanceAnalysis(ttest.randomTraceSet, "di3","di4")
