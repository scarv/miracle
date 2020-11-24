
import os
import logging as log

import scipy.signal as si
from   scipy.ndimage import median_filter

EXPERIMENT_CATAGORY = "regfile"
EXPERIMENT_NAME     = "neighbour-hw"

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
        
        aif.runAverageTraceForTraceSetBlob(blob)

        #up=1
        #down=3
        #traces = si.resample_poly (
        #    blob.getTracesAsNdArray(), up=up, down=down, axis=1
        #)
        traces = blob.getTracesAsNdArray()

        aif.runHammingWeightAnalysis  (blob, "di1",traces=traces)
        aif.runHammingWeightAnalysis  (blob, "di2",traces=traces)
        aif.runHammingWeightAnalysis  (blob, "di3",traces=traces)
        aif.runHammingWeightAnalysis  (blob, "di4",traces=traces)

        aif.runHammingDistanceAnalysis(blob, "di1","di2",traces=traces)
        aif.runHammingDistanceAnalysis(blob, "di1","di3",traces=traces)
        aif.runHammingDistanceAnalysis(blob, "di1","di4",traces=traces)
        aif.runHammingDistanceAnalysis(blob, "di2","di3",traces=traces)
        aif.runHammingDistanceAnalysis(blob, "di2","di4",traces=traces)
        aif.runHammingDistanceAnalysis(blob, "di3","di4",traces=traces)
