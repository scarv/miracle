
from sqlalchemy import Column, Integer, String

from . import Base

class Device(Base):
    """
    Represents a single target device for which there is experimental
    data. Present in the database.
    """

    __tablename__ = "devices"

    id      = Column(Integer, primary_key=True)
    name    = Column(String)

