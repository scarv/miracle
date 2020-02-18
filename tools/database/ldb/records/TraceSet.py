
from sqlalchemy import Column, Integer, String, ForeignKey

from . import Base

class TraceSet(Base):
    """
    Describes a single trace set from which statistic traces
    are derived.
    """
    
    __tablename__ = "trace_sets"

    id               = Column(Integer, primary_key=True)
    set_type         = Column(String)
    filepath_fix     = Column(String)
    filepath_random  = Column(String)
    experimentId     = Column(Integer, ForeignKey("experiments.id"))
    targetId         = Column(Integer, ForeignKey("targets.id"))
    scope_samplerate = Column(Integer, default = 0)
    scope_resolution = Column(Integer, default = 0)
    trace_length     = Column(Integer, default = 0)
    device_freq      = Column(Integer, default = 0)
