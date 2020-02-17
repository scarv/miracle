
from sqlalchemy import Column, Integer, String

from . import Base

class Board(Base):
    """
    Represents an PCB / circuit board used to collect experiment data.
    A board may be a host for one or more devices.
    """

    __tablename__ = "boards"

    id              = Column(Integer, primary_key=True)
    name            = Column(String, unique=True)
    description     = Column(String)
    product_link    = Column(String)
    manufacturer    = Column(String)

