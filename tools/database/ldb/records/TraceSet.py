
import datetime

from sqlalchemy import Column, DateTime, Integer, String, ForeignKey

from . import Base

class TraceSet(Base):
    """
    Describes a single trace set from which statistic traces
    are derived.
    """
    
    __tablename__ = "trace_sets"

    id               = Column(Integer, primary_key=True)
    set_type         = Column(String)
    filepath_fixed   = Column(String)
    filepath_traces  = Column(String)
    timestamp        = Column(DateTime, default=datetime.datetime.now)
    experimentId     = Column(Integer, ForeignKey("experiments.id"))
    targetId         = Column(Integer, ForeignKey("targets.id"))
    scope_samplerate = Column(Integer, default = 0)
    scope_resolution = Column(Integer, default = 0)
    trace_length     = Column(Integer, default = 0)
    device_freq      = Column(Integer, default = 0)
    parameters       = Column(String, default="")

    def __repr__(self):
        return "%5d, %-5s, %-16s, %5d, %5d, %d, %d, %d %-40s" % (
            self.id, self.set_type, self.timestamp, self.experimentId,
            self.targetId,
            self.scope_samplerate, self.scope_resolution,
            self.device_freq,
            self.filepath_traces
        )
