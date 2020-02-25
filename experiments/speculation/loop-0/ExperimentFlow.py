
import os
import logging as log

EXPERIMENT_CATAGORY = "speculation"
EXPERIMENT_NAME     = "loop-0"

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

