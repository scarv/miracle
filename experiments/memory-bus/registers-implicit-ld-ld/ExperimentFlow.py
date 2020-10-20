
import os
import logging as log

EXPERIMENT_CATAGORY = "memory-bus"
EXPERIMENT_NAME     = "registers-implicit-ld-ld"
    
idx1_list = [16, 19]
idx2_list = [16, 19, 20]

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """

    for idx1 in idx1_list:
        for idx2 in idx2_list:

            variables = {"idx1":idx1, "idx2":idx2}

            args.runAndInsertTraceCollection(
                EXPERIMENT_CATAGORY ,
                EXPERIMENT_NAME     ,
                variables           ,
                args.num_ttest_traces
            )

    return 0


def runAnalysis(aif):
    """
    Run any experiment specific analysis.

    aif - AnalysisInterface instance
    """

    for blob in aif.getTraceSetBlobsForTargetAndExperiment():
        aif.runHammingWeightAnalysis(blob, "di1")
        aif.runHammingWeightAnalysis(blob, "di2")
        aif.runHammingDistanceAnalysis(blob, "di1", "di2")
        aif.runAverageTraceForTraceSetBlob(blob)

