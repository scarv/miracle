
import sqlalchemy

from .BaseBackend   import BaseBackend
from ..records      import Base

class SQLiteBackend(BaseBackend):
    """
    An SQLite backed version of the database.
    """
    
    def __init__(self, path):
        """
        Connect to the SQlite database at the supplied path.
        """
        BaseBackend.__init__(self)
        return NotImplementedError()


    def createNew(path):
        """
        Create a new SQLite backed database using the supplied target
        path and engine.
        """

        engine = sqlalchemy.create_engine(path, echo=False)

        Base.metadata.create_all(engine)

        return True

        
