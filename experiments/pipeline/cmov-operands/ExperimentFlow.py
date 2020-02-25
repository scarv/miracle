
import os
import logging as log

EXPERIMENT_CATAGORY = "pipeline"
EXPERIMENT_NAME     = "cmov-operands"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """
    for sel in [0, 1]:
        result = args.runAndInsertTTest (
            EXPERIMENT_CATAGORY ,
            EXPERIMENT_NAME     ,
            {"sel": sel}
        )
        if(result != 0):
            return result

    return 0

