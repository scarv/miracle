
import os
import sqlite3
import logging  as log

import sqlalchemy

from .BaseBackend   import BaseBackend
from ..records      import Base

class SQLiteBackend(BaseBackend):
    """
    An SQLite backed version of the database.
    """
    
    def __init__(self, path, autocommit=False):
        """
        Connect to the SQlite database at the supplied path.
        """
        BaseBackend.__init__(self, path, autocommit=autocommit)


    def createNew(path):
        """
        Create a new SQLite backed database using the supplied target
        filepath and engine.
        """

        if(os.path.isfile(path)):
            log.info("Database file at '%s' already exists." % path)
        else:
            conn = sqlite3.connect(path)
            conn.close()

        fullpath    = "sqlite:///" + path
        engine      = sqlalchemy.create_engine(fullpath, echo=False)

        Base.metadata.create_all(engine)

        return True

        
