
import io
import gzip

import numpy as np

from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, Enum
from sqlalchemy.types import BLOB as Blob

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
    traces      = Column(Blob)

    def __repr__(self):
        return "%5d, %s" % (self.id, self.compression)


    def fromTraces(traces, compression = TraceCompression.GZIP):
        """
        Create a new TraceSetBlob object from the supplied traces with the
        specified compression, ready for insertion into the database.
        """
        return TraceSetBlob (
            compression = compression,
            traces      = TraceSetBlob.compress(traces, compression)
        )

    def compress(traces, compression):
        """
        Returns a BytesIO object to which the traces have been written
        and compressed, ready for storage in the database
        """

        bio = io.BytesIO()
        
        np.save(bio, traces)

        if(compression == TraceCompression.NONE):
            return bio.read()
        if(compression == TraceCompression.GZIP):
            return gzip.compress(bio.read())
        else:
            raise Exception("Unknown compression type: %s" % compression)


    def decompress(traces_bytes, compression):
        """
        Return an np.ndarray, which is decompressed from the supplied
        traces paramter.
        """
        assert(isinstance(traces_bytes,bytes))

        bio = io.BytesIO(traces_bytes)

        if(compression == TraceCompression.NONE):
            return np.load(bio)

        elif(compressed == TraceCompression.GZIP):
            gzfh = gzip.GzipFile(bio, "r")
            return np.load(gzfh)

        else:
            raise Exception("Unknown compression type: %s" % compression)
