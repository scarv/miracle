
import os
import logging as log

EXPERIMENT_CATAGORY = "memory-bus"
EXPERIMENT_NAME     = "bus-width-ld-halfword"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """
    off = 2

    for idx in range(1,5):
        variables = {"off" : off, "idx" : idx}

        args.runAndInsertTraceCollection (
            EXPERIMENT_CATAGORY ,
            EXPERIMENT_NAME     ,
            variables           ,
            int(args.num_ttest_traces)
        )

    return 0

def runAnalysis(aif):
    """
    Run any experiment specific analysis.

    aif - AnalysisInterface instance
    """

    for blob in aif.getTraceSetBlobsForTargetAndExperiment():
        aif.runHammingWeightAnalysis(blob, "din")

