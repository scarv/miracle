
from sqlalchemy import Column, Integer, String, ForeignKey

from . import Base

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
