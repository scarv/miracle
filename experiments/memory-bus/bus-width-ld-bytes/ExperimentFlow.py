
import os
import logging as log

EXPERIMENT_CATAGORY = "memory-bus"
EXPERIMENT_NAME     = "bus-width-ld-bytes"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """
    off = 5
    wd  = args.work_dir

    for idx in range(0,9):
        log.info("TTEST: offset = %d, idx = %d" % (off, idx))

        args.target_comms.doInitExperiment()

        args.work_dir = args.createWorkDirSub("idx_%d_off_%d" % (idx,off))

        variables = {"off" : off, "idx" : idx}

        ttest = args.createTTestCaptureClass(variables)
        ttest.reportVariables()
        ttest.performTTest()

        ts_name = "%s_%s_%s_%d_%d" % (
            EXPERIMENT_CATAGORY,EXPERIMENT_NAME,args.target_name,off,idx
        )

        dbinsert_result = args.dbInsertTTestTraceSet(
            ttest,
            ts_name,
            EXPERIMENT_CATAGORY,
            EXPERIMENT_NAME
        )

        if(dbinsert_result != 0):
            return dbinsert_result

    return 0


def runAnalysis(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """
    print("Analyse")
