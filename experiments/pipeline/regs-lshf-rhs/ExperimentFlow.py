
import os
import logging as log

EXPERIMENT_CATAGORY = "pipeline"
EXPERIMENT_NAME     = "regs-lshf-rhs"

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

