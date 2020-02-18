
from sqlalchemy import Column, Integer, String

from . import Base

class Device(Base):
    """
    Represents a single target device for which there is experimental
    data present in the database.
    A Device in this context means a physical SoC or FPGA.
    """

    __tablename__ = "devices"

    id              = Column(Integer, primary_key=True)
    name            = Column(String, unique=True)
    description     = Column(String)
    product_link    = Column(String)
    datasheet_link  = Column(String)
    manufacturer    = Column(String)

    def __repr__(self):
        return "%4d, %-20s, %-25s, %s" % (
            self.id, self.name, self.manufacturer, self.description
        )

    def fromCFGDict(cfg):
        """
        Create a new Device row ready to insert into the database from
        a CFG file dict.
        """

        dev = cfg["DEVICE"]

        return Device(
            name = dev["NAME"],
            description = dev["MANUFACTURER_LINK"],
            manufacturer= dev["MANUFACTURER_NAME"],
            datasheet_link=dev["LINK"]
        )

