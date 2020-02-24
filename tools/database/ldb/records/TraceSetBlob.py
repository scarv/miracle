
import io
import gzip
import logging as log

import numpy as np

from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, Enum, Binary

from . import Base
from . import TraceCompression

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
        tr = TraceSetBlob ()
        tr.setTraces(traces, compression = compression)
        return tr

    def compress(traces, compression):
        """
        Returns a BytesIO object to which the traces have been written
        and compressed, ready for storage in the database
        """
        bio = io.BytesIO()
        
        np.save(bio, traces, allow_pickle = True)

        if(compression == TraceCompression.NONE):
            return bio.getvalue()
        if(compression == TraceCompression.GZIP):
            return gzip.compress(bio.getvalue())
        else:
            raise Exception("Unknown compression type: %s" % compression)

    def decompress(traces_bytes, compression):
        """
        Return an np.ndarray, which is decompressed from the supplied
        traces paramter.
        """
        assert(isinstance(traces_bytes,bytes))

        if(compression == TraceCompression.NONE):
            bio = io.BytesIO(traces_bytes)
            return np.load(bio)

        elif(compression == TraceCompression.GZIP):
            bio = io.BytesIO(gzip.decompress(traces_bytes))
            return np.load(bio)

        else:
            raise Exception("Unknown compression type: %s" % compression)

    def getTracesAsNdArray(self):
        """
        Return the decompressed traces of this blob as a numpy.NdArray.
        """
        return TraceSetBlob.decompress(self.traces,self.compression)

    def setTraces(self, traces, compression = TraceCompression.NONE):
        """
        Set the traces field of the record, compressing as needed, and
        update the traceCount and traceLen fields.
        """
        assert(isinstance(traces, np.ndarray))
        self.traceCount, self.traceLen = traces.shape
        self.traces     = TraceSetBlob.compress(traces, compression)
        assert(len(self.traces) > 0),"Trace data length  = 0"
        self.compression= compression

