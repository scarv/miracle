
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
        aif.runHammingWeightAnalysis(blob, "di3")
        aif.runHammingWeightAnalysis(blob, "di4")
        
        # Hamming distance between consecutive operands
        aif.runHammingDistanceAnalysis(blob, "di1","di2")
        aif.runHammingDistanceAnalysis(blob, "di2","di3")
        aif.runHammingDistanceAnalysis(blob, "di3","di4")

        #
        # Compute hamming distance between consecutive instruciton results.

        vdi1 = aif.getVariableArrayFromTraceSet(blob, "di1")
        vdi2 = aif.getVariableArrayFromTraceSet(blob, "di2")
        vdi3 = aif.getVariableArrayFromTraceSet(blob, "di3")
        vdi4 = aif.getVariableArrayFromTraceSet(blob, "di4")
        
        adi1 = aif.convertArrayBytesToInt(vdi1.getValuesAsNdArray())
        adi2 = aif.convertArrayBytesToInt(vdi2.getValuesAsNdArray())
        adi3 = aif.convertArrayBytesToInt(vdi3.getValuesAsNdArray())
        adi4 = aif.convertArrayBytesToInt(vdi4.getValuesAsNdArray())

        # Compute 2* each value of the input arrays, since each add
        # instruction just adds x to x.
        adi1_x2 = adi1 + adi1
        adi2_x2 = adi2 + adi2
        adi3_x2 = adi3 + adi3
        adi4_x2 = adi4 + adi4

        # Hamming distance between Consecutive results
        hd_result_12 = scass.cpa.hammingDistanceCorrolation (
            blob.getTracesAsNdArray(), adi1_x2, adi2_x2
        )
        hd_result_23 = scass.cpa.hammingDistanceCorrolation (
            blob.getTracesAsNdArray(), adi2_x2, adi3_x2
        )
        hd_result_34 = scass.cpa.hammingDistanceCorrolation (
            blob.getTracesAsNdArray(), adi3_x2, adi4_x2
        )

        # Insert the trace
        aif.insertCorrolationTrace(
            [blob],[vdi1,vdi2], hd_result_12, 
            aif.generateStatTraceName(blob,"Hamming Distance","result di1->di2"),
            ldb.records.StatTraceType.HD,
            ldb.records.CorrolationType.HAMMING_DISTANCE
        )
        aif.insertCorrolationTrace(
            [blob],[vdi2,vdi3], hd_result_23, 
            aif.generateStatTraceName(blob,"Hamming Distance","result di2->di3"),
            ldb.records.StatTraceType.HD,
            ldb.records.CorrolationType.HAMMING_DISTANCE
        )
        aif.insertCorrolationTrace(
            [blob],[vdi3,vdi4], hd_result_34, 
            aif.generateStatTraceName(blob,"Hamming Distance","result di3->di4"),
            ldb.records.StatTraceType.HD,
            ldb.records.CorrolationType.HAMMING_DISTANCE
        )
