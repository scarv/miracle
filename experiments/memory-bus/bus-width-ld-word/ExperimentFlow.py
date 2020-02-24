
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
        variables = {"off" : off, "idx" : idx}

        args.runAndInsertTTest (
            EXPERIMENT_CATAGORY ,
            EXPERIMENT_NAME     ,
            variables
        )

    return 0

