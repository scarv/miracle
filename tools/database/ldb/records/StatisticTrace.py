
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.types import BLOB as Blob

from . import Base
from . import TRACE_COMPRESSION_NONE

class StatisticTrace(Base):
    """
    Represents a single statistic trace for a given experiment and
    device pair.
    """

    __tablename__ = "statistic_traces"

    id          = Column(Integer, primary_key=True)
    filepath    = Column(String)
    traceSetId  = Column(Integer, ForeignKey("trace_sets.id"))
    compression = Column(Integer, default = TRACE_COMPRESSION_NONE)
    traceType   = Column(String)
    trace       = Column(Blob)
