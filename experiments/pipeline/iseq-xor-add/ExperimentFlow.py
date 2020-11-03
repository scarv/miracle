
import os
import logging as log

EXPERIMENT_CATAGORY = "pipeline"
EXPERIMENT_NAME     = "iseq-xor-add"

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
        aif.runHammingDistanceAnalysis(blob, "di1","di2")
        aif.runHammingDistanceAnalysis(blob, "di1","di3")
        aif.runHammingDistanceAnalysis(blob, "di1","di4")
        aif.runHammingDistanceAnalysis(blob, "di2","di3")
        aif.runHammingDistanceAnalysis(blob, "di2","di4")
        aif.runHammingDistanceAnalysis(blob, "di3","di4")
