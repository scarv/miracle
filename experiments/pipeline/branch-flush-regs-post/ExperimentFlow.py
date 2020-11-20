
import os
import logging as log

EXPERIMENT_CATAGORY = "pipeline"
EXPERIMENT_NAME     = "branch-flush-regs-post"

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

        di1_xor_di2 = aif.opXor(blob, "di1", "di2")
        di3_xor_di4 = aif.opXor(blob, "di3", "di4")

        aif.runHammingDistanceAnalysis(blob,
            di1_xor_di2, di3_xor_di4, "HD(d1^d2,d3^d4)")

        aif.runHammingDistanceAnalysis(blob, "di1","di2")
        aif.runHammingDistanceAnalysis(blob, "di1","di3")
        aif.runHammingDistanceAnalysis(blob, "di1","di4")
        aif.runHammingDistanceAnalysis(blob, "di2","di3")
        aif.runHammingDistanceAnalysis(blob, "di2","di4")
        aif.runHammingDistanceAnalysis(blob, "di3","di4")
        aif.runHammingWeightAnalysis(blob, "di1")
        aif.runHammingWeightAnalysis(blob, "di2")
        aif.runHammingWeightAnalysis(blob, "di3")
        aif.runHammingWeightAnalysis(blob, "di4")

