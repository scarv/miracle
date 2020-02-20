
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
    manufacturer_name   = Column(String)
    manufacturer_link   = Column(String)
    product_link        = Column(String)
    architecture_link   = Column(String)
    architecture_name   = Column(String)
    

    def __repr__(self):
        return "%4d, %-20s, %-10s, %-10s %s" % (
            self.id, self.name, self.architecture_name, self.coretype,
            self.description
        )
    
    def fromCFGDict(cfg):
        """
        Create a new Core row ready to insert into the database from
        a CFG file dict.
        """

        dev = cfg["CPU"]

        return Core(
            name                = dev["CORE_NAME"],
            coretype            = "CPU",
            description         = "",
            manufacturer_name   = dev["CORE_MANUFACTURER_NAME"],
            manufacturer_link   = dev["CORE_MANUFACTURER_LINK"],
            product_link        = dev["CORE_LINK"],
            architecture_link   = dev["ARCH_LINK"],
            architecture_name   = dev["ARCH_NAME"]
        )

