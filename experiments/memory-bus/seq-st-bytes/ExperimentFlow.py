
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

    variables = ["d0","d1","d2"]

    done = set([])

    for blob in aif.getTraceSetBlobsForTargetAndExperiment():
        aif.runAverageTraceForTraceSetBlob(blob)

        for x in variables:
            for y in variables:

                tag = (x,y)
                if(y<x):
                    tag=(y,x)
                if(tag in done):
                    continue

                if(x!=y):
                    aif.runHammingDistanceAnalysis(blob, x, y)
                done.add(tag)

            aif.runHammingWeightAnalysis(blob, x)
