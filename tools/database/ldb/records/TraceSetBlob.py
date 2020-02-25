
import io
import logging as log

import numpy as np

from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, Enum, Binary, Table
from sqlalchemy.orm import relationship

from . import Base
from . import TraceCompression
from . import compressNDArray
from . import decompressNDArray


traceset_blob_var_values_association = Table (
    "traceset_blob_var_values_association", Base.metadata,
    Column("traceSetBlobId", Integer, ForeignKey("traceset_blobs.id")),
    Column("variableValuesId", Integer, ForeignKey("variable_values.id"))
)

class TraceSetBlob(Base):
    """
    Represents a single set of numpy traces as a 2D numpy ndarray object.

    The trace field contains the (possibly) compressed raw binary
    representation, which is expanded or not as needed.
    """

    __tablename__ = "traceset_blobs"

    id          = Column(Integer, primary_key=True)
    compression = Column(Enum(TraceCompression), default = TraceCompression.NONE)
    traceLen    = Column(Integer, default = 0)
    traceCount  = Column(Integer, default = 0)
    traces      = Column(Binary)

    variableValues   = relationship(
        "VariableValues",
        secondary = traceset_blob_var_values_association
    )

    def __repr__(self):
        return "%5d, %s, %5d, %5d" % (
            self.id, self.compression, self.traceLen, self.traceCount
        )

    @property
    def shape(self):
        """
        Return the size of the trace set as a tuple:
        (number of traces, length of each trace)
        """
        return (self.traceCount, self.traceLen)

    def fromTraces(traces, compression = TraceCompression.GZIP):
        """
        Create a new TraceSetBlob object from the supplied traces with the
        specified compression, ready for insertion into the database.
        """
        assert(isinstance(traces, np.ndarray))
        tr = TraceSetBlob ()
        tr.setTraces(traces, compression = compression)
        return tr

    def getTracesAsNdArray(self):
        """
        Return the decompressed traces of this blob as a numpy.NdArray.
        """
        return decompressNDArray(self.traces,self.compression)

    def setTraces(self, traces, compression = TraceCompression.NONE):
        """
        Set the traces field of the record, compressing as needed, and
        update the traceCount and traceLen fields.
        """
        assert(isinstance(traces, np.ndarray))
        
        self.traceCount, self.traceLen = traces.shape
        self.traces     = compressNDArray(traces, compression)
        
        assert(len(self.traces) > 0),"Trace data length  = 0"

        self.compression= compression

