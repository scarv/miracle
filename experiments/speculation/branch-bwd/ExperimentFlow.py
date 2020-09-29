
import os
import logging as log

import scass
import ldb

EXPERIMENT_CATAGORY = "speculation"
EXPERIMENT_NAME     = "branch-bwd"

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

        # Hamming weight of each operands
        aif.runHammingWeightAnalysis(blob, "di1")
        aif.runHammingWeightAnalysis(blob, "di2")
        
        # Hamming distance between consecutive operands
        aif.runHammingDistanceAnalysis(blob, "di1","di2")

        #
        # Compute hamming distance between consecutive instruciton results.

        vdi1 = aif.getVariableArrayFromTraceSet(blob, "di1")
        vdi2 = aif.getVariableArrayFromTraceSet(blob, "di2")
        
        adi1 = aif.convertArrayBytesToInt(vdi1.getValuesAsNdArray())
        adi2 = aif.convertArrayBytesToInt(vdi2.getValuesAsNdArray())

        # Compute 2* each value of the input arrays, since each add
        # instruction just adds x to x.
        adi1_x2 = adi1 + adi1
        adi2_x2 = adi2 + adi2

        # Hamming distance between Consecutive results
        hd_result_12 = scass.cpa.hammingDistanceCorrolation (
            blob.getTracesAsNdArray(), adi1_x2, adi2_x2
        )

        # Insert the trace
        aif.insertCorrolationTrace(
            [blob],[vdi1,vdi2], hd_result_12, 
            aif.generateStatTraceName(blob,"Hamming Distance","result di1->di2"),
            ldb.records.StatTraceType.HD,
            ldb.records.CorrolationType.HAMMING_DISTANCE
        )
