
import os
import logging as log

class DefaultConfig(object):
    """
    The default application configuration object.
    """

    def __init__(self):

        self.LOG_LEVEL = log.INFO
        
        # Root directory of the UAS source code repository.
        self.UAS_ROOT = os.getenv("UAS_ROOT",default="")

        # Where to open the database connection from.
        self.DB_PATH  = os.path.expandvars("$UAS_ROOT/work/database.sqlite")

        # Database engine backend.
        self.DB_BACKEND = "sqlite"

