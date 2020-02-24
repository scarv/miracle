
import os
import logging as log

EXPERIMENT_CATAGORY = "memory-bus"
EXPERIMENT_NAME     = "bus-width-ld-word"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """
    off = 1

    for idx in range(0,2):
        log.info("TTEST: offset = %d, idx = %d" % (off, idx))

        args.target_comms.doInitExperiment()

        variables = {"off" : off, "idx" : idx}

        ttest = args.createTTestCaptureClass(variables)
        ttest.performTTest()

        dbinsert_result = args.dbInsertTTestTraceSet(
            ttest,
            EXPERIMENT_CATAGORY,
            EXPERIMENT_NAME
        )

        if(dbinsert_result != 0):
            return dbinsert_result

    return 0

