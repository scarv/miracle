
import os
import logging as log

EXPERIMENT_CATAGORY = "regfile"
EXPERIMENT_NAME     = "neighbour-hw"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """
    return args.runAndInsertTTest (
            EXPERIMENT_CATAGORY ,
            EXPERIMENT_NAME     ,
            {}
        )

