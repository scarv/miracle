
import os
import logging as log

class DefaultConfig(object):
    """
    The default application configuration object.
    """

    def __init__(self):

        self.LOG_LEVEL = log.INFO
       
        # The very top level of where all results are kept
        self.RESULTS_DIRECTORY = os.getenv("UAS_BUILD",default=None)

        if(self.RESULTS_DIRECTORY == None):
            log.error("Could not find UAS_BUILD environment variable")
        
        # Experiment classes / directories we expect to exist in
        # self.RESULTS_DIRECTORY
        self.EXPERIMENT_CLASSES = [
            "pipeline",
            "memory-bus",
            "speculation",
            "countermeasures"
        ]

        self.EXPERIMENT_DIRS = [
            os.path.join(self.RESULTS_DIRECTORY,d) 
                for d in self.EXPERIMENT_CLASSES
        ]
        
        # Root directory of the UAS source code repository.
        self.UAS_ROOT = os.getenv("UAS_ROOT",default="")

