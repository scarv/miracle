
import os
import logging as log

EXPERIMENT_CATAGORY = "countermeasures"
EXPERIMENT_NAME     = "rosita-ld-ld-3"

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

