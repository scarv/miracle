
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

    for idx in range(0,9):
        variables = {"off" : off, "idx" : idx}

        args.runAndInsertTTest (
            EXPERIMENT_CATAGORY ,
            EXPERIMENT_NAME     ,
            variables
        )

    return 0

