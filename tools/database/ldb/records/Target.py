
from sqlalchemy import Column, Integer, String, ForeignKey

from . import Base

class Target(Base):
    """
    Represents a tuple of (CPU, Device, Board). This is a single
    target device against which we do leakage experiments.
    """

    __tablename__ = "targets"

    id              = Column(Integer, primary_key=True)
    name            = Column(String, unique=True)
    description     = Column(String)
    deviceid        = Column(Integer, ForeignKey("devices.id"))
    boardid         = Column(Integer, ForeignKey("boards.id"))
    cpuid           = Column(Integer, ForeignKey("cores.id"))

