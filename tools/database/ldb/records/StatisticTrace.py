
import io
import logging as log
import datetime

import numpy as np

from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, Enum, Binary

from . import Base
from . import TraceCompression
from . import StatTraceType
from . import compressNDArray
from . import decompressNDArray

class StatisticTrace(Base):
    """
    Represents a statistic trace derived from zero or more TTraceSets and
    their associated trace blobs..
    """

    __tablename__ = "statistic_traces"

    id          = Column(Integer, primary_key=True)
    compression = Column(Enum(TraceCompression), default = TraceCompression.NONE)
    stat_type   = Column(Enum(StatTraceType), nullable = False)
    trace_bin   = Column(Binary)

    def __repr__(self):
        return "%5d, %6s, %s" % (
            self.id, self.stat_type.name, self.compression
        )

    def fromTraceArray(trace, stat_type, compression = TraceCompression.GZIP):
        """
        Create a new StatisticTrace object from the supplied values with the
        specified compression, ready for insertion into the database.
        """
        assert(isinstance(trace, np.ndarray))

        tr = StatisticTrace (
            stat_type = stat_type
        )
        tr.setTraceValues(trace, compression = compression)

        return tr

    def getValuesAsNdArray(self):
        """
        Return the decompressed values of this blob as a numpy.NdArray.
        """
        return decompressNDArray(self.trace_bin,self.compression)

    def setTraceValues(self, trace, compression = TraceCompression.GZIP):
        """
        Set the trace_bin field of the record, compressing as needed.
        """
        assert(isinstance(trace, np.ndarray))
        
        self.trace_bin = compressNDArray(trace, compression)
        
        assert(len(self.trace_bin) > 0),"Trace data length  = 0"

        self.compression= compression

