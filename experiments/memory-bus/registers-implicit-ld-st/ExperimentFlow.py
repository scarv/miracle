
import os
import logging as log

EXPERIMENT_CATAGORY = "memory-bus"
EXPERIMENT_NAME     = "registers-implicit-ld-st"

def runCapture(args):
    """
    Top level function for running all trace capture processes for this
    experiment.
    """
    idx1_list = [16]
    idx2_list = [16, 19, 20]

    for idx1 in idx1_list:
        for idx2 in idx2_list:

            variables = {"idx1":idx1, "idx2":idx2}

            args.runAndInsertTTest (
                EXPERIMENT_CATAGORY ,
                EXPERIMENT_NAME     ,
                variables
            )

    return 0


