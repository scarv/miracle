
import os
import logging as log

import scass
import ldb

EXPERIMENT_CATAGORY = "speculation"
EXPERIMENT_NAME     = "jump-bwd"

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
        di5_xor_di6 = aif.opXor(blob, "di5", "di6")

        aif.runHammingDistanceAnalysis(blob,
            di1_xor_di2, di3_xor_di4, "HD(d1^d2,d3^d4)")
        
        aif.runHammingDistanceAnalysis(blob,
            di1_xor_di2, di5_xor_di6, "HD(d1^d2,d5^d6)")
        
        aif.runHammingDistanceAnalysis(blob,
            di3_xor_di4, di5_xor_di6, "HD(d3^d4,d5^d6)")

        aif.runHammingDistanceAnalysis(blob, "di1","di2")
        aif.runHammingDistanceAnalysis(blob, "di1","di3")
        aif.runHammingDistanceAnalysis(blob, "di1","di4")
        aif.runHammingDistanceAnalysis(blob, "di1","di5")
        aif.runHammingDistanceAnalysis(blob, "di1","di6")

        aif.runHammingDistanceAnalysis(blob, "di2","di3")
        aif.runHammingDistanceAnalysis(blob, "di2","di4")
        aif.runHammingDistanceAnalysis(blob, "di2","di5")
        aif.runHammingDistanceAnalysis(blob, "di2","di6")

        aif.runHammingDistanceAnalysis(blob, "di3","di4")
        aif.runHammingDistanceAnalysis(blob, "di3","di5")
        aif.runHammingDistanceAnalysis(blob, "di3","di6")
        
        aif.runHammingDistanceAnalysis(blob, "di4","di5")
        aif.runHammingDistanceAnalysis(blob, "di4","di6")
        
        aif.runHammingDistanceAnalysis(blob, "di5","di6")

        aif.runHammingWeightAnalysis(blob, "di1")
        aif.runHammingWeightAnalysis(blob, "di2")
        aif.runHammingWeightAnalysis(blob, "di3")
        aif.runHammingWeightAnalysis(blob, "di4")
        aif.runHammingWeightAnalysis(blob, "di5")
        aif.runHammingWeightAnalysis(blob, "di6")

