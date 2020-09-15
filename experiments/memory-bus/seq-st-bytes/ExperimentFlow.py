
import os
import logging as log

EXPERIMENT_CATAGORY = "memory-bus"
EXPERIMENT_NAME     = "seq-st-bytes"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """

    variables = {}

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
        aif.runHammingDistanceAnalysis(blob, "d0", "d1")
        aif.runHammingDistanceAnalysis(blob, "d1", "d2")
        aif.runHammingDistanceAnalysis(blob, "d2", "d0")
        
        aif.runHammingWeightAnalysis(blob, "d0")
        aif.runHammingWeightAnalysis(blob, "d1")
        aif.runHammingWeightAnalysis(blob, "d2")

