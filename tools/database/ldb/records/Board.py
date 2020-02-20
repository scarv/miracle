
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


    def __repr__(self):
        return "%4d, %-30s, %-25s, %s" % (
            self.id, self.name, self.manufacturer, self.description
        )

    def fromCFGDict(cfg):
        """
        Create a new Board row ready to insert into the database from
        a CFG file dict.
        """

        dev = cfg["BOARD"]

        return Board(
            name         = dev["NAME"],
            description  = dev["MANUFACTURER_LINK"],
            manufacturer = dev["MANUFACTURER_NAME"],
            product_link = dev["LINK"]
        )

