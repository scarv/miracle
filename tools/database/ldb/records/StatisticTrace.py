
from sqlalchemy import Column, Integer, String, ForeignKey

from . import Base

TRACE_COMPRESSION_NONE = 0
TRACE_COMPRESSION_GZ   = 1

class StatisticTrace(Base):
    """
    Represents a single statistic trace for a given experiment and
    device pair.
    """

    __tablename__ = "statistic_traces"

    id          = Column(Integer, primary_key=True)
    filepath    = Column(String)
    traceSetId  = Column(Integer, ForeignKey("trace_sets.id"))
    experimentId= Column(Integer, ForeignKey("experiments.id"))
    targetId    = Column(Integer, ForeignKey("targets.id"))
    compression = Column(Integer, default = TRACE_COMPRESSION_NONE)
