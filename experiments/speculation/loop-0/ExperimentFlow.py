
import os
import logging as log

EXPERIMENT_CATAGORY = "speculation"
EXPERIMENT_NAME     = "loop-0"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """

    args.runAndInsertTraceCollection (
        EXPERIMENT_CATAGORY ,
        EXPERIMENT_NAME     ,
        {}                  ,
        int(args.num_ttest_traces)
    )

def runAnalysis(aif):
    """
    Run any experiment specific analysis.

    aif - AnalysisInterface instance
    """
    
    for blob in aif.getTraceSetBlobsForTargetAndExperiment():
        aif.runHammingWeightAnalysis(blob, "di1")

