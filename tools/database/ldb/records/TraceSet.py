
from sqlalchemy import Column, Integer, String, ForeignKey

from . import Base

class TraceSet(Base):
    """
    Describes a single trace set from which statistic traces
    are derived.
    """
    
    __tablename__ = "trace_sets"

    id          = Column(Integer, primary_key=True)
    filepath    = Column(String)
    experimentId= Column(Integer, ForeignKey("experiments.id"))
    targetId    = Column(Integer, ForeignKey("targets.id"))
