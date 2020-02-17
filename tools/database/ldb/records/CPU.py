
from sqlalchemy import Column, Integer, String

from . import Base

class CPU(Base):
    """
    Represents a single CPU being experimented on. A CPU may be present
    in one or more devices.
    """

    __tablename__ = "cpus"

    id                  = Column(Integer, primary_key=True)
    name                = Column(String, unique=True)
    description         = Column(String)
    manufacturer        = Column(String)
    product_link        = Column(String)
    architecture_link   = Column(String)
    architecture_name   = Column(String)
    pipeline_depth      = Column(Integer)


