
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
