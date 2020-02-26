
from sqlalchemy import Column, Integer, String, ForeignKey

from . import Base

class Experiment(Base):
    """
    Represents all information on a single experiment in the
    database.
    """

    __tablename__ = "experiments"

    id          = Column(Integer, primary_key=True)
    name        = Column(String)
    catagory    = Column(String)
    description = Column(String)

    def __repr__(self):
        return "%4d, %-20s, %-40s, %s" % (
            self.id, self.catagory, self.name, self.description
        )

    @property
    def fullname(self):
        return "%s/%s" % (self.catagory, self.name)
