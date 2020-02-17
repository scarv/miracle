
from sqlalchemy import Column, Integer, String

from . import Base

class Core(Base):
    """
    Represents a single Core being experimented on. A Core may be present
    in one or more devices, and may be a CPU or a dedicated crypto core.
    """

    __tablename__ = "cores"

    id                  = Column(Integer, primary_key=True)
    name                = Column(String, unique=True)
    coretype            = Column(String)
    description         = Column(String)
    manufacturer        = Column(String)
    product_link        = Column(String)
    architecture_link   = Column(String)
    architecture_name   = Column(String)

