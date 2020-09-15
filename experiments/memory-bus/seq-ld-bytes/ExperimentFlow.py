
import os
import logging as log

EXPERIMENT_CATAGORY = "memory-bus"
EXPERIMENT_NAME     = "seq-ld-bytes"

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
        aif.runHammingDistanceAnalysis(blob, "d2", "d3")
        aif.runHammingDistanceAnalysis(blob, "d3", "d4")
        aif.runHammingDistanceAnalysis(blob, "d4", "d5")
        aif.runHammingDistanceAnalysis(blob, "d5", "d6")
        aif.runHammingDistanceAnalysis(blob, "d0", "d4")
        aif.runHammingDistanceAnalysis(blob, "d1", "d5")
        aif.runHammingDistanceAnalysis(blob, "d2", "d6")
        aif.runHammingDistanceAnalysis(blob, "d3", "d7")
        
        aif.runHammingWeightAnalysis(blob, "d0")
        aif.runHammingWeightAnalysis(blob, "d1")
        aif.runHammingWeightAnalysis(blob, "d2")
        aif.runHammingWeightAnalysis(blob, "d3")
        aif.runHammingWeightAnalysis(blob, "d4")
        aif.runHammingWeightAnalysis(blob, "d5")
        aif.runHammingWeightAnalysis(blob, "d6")
        aif.runHammingWeightAnalysis(blob, "d7")

