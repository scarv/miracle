
import enum
import datetime
import gzip
import zlib
import io
import logging as log

import numpy as np

from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class TraceCompression(enum.Enum):
    NONE    = 1
    GZIP    = 2
    ZLIB    = 3

class StatTraceType(enum.Enum):
    TTRACE  = 0
    AVG     = 1
    STD     = 2
    MIN     = 3
    MAX     = 4
    RNG     = 5
    HW      = 6
    HD      = 7

def compressNDArray(traces, compression):
    """
    Returns a BytesIO object to which the traces have been written
    and compressed, ready for storage in the database
    """
    bio = io.BytesIO()

    np.save(bio, traces, allow_pickle = True)

    tr = None

    compress_begin = datetime.datetime.now()

    if(compression == TraceCompression.NONE):
        tr = bio.getvalue()

    elif(compression == TraceCompression.GZIP):
        tr = gzip.compress(bio.getvalue(), compresslevel = 9)

    elif(compression == TraceCompression.ZLIB):
        tr = zlib.compress(bio.getvalue(), level = 9)

    else:
        raise Exception("Unknown compression type: %s" % compression)

    compress_time = datetime.datetime.now() - compress_begin

    assert(isinstance(tr,bytes)),"Return value of TraceSetBlob.compress() should be of type 'bytes'"

    log.info("Compressed %d bytes down to %d. Ratio = %.2fx. Took %s using %s compression." % (
        traces.size, len(tr), len(tr)/traces.size, compress_time,
        compression.name
    ))

    return tr

def decompressNDArray(traces_bytes, compression):
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

    elif(compression == TraceCompression.ZLIB):
        bio = io.BytesIO(zlib.decompress(traces_bytes))
        return np.load(bio)

    else:
        raise Exception("Unknown compression type: %s" % compression)

from .Device         import Device
from .Board          import Board
from .Core           import Core
from .Target         import Target
from .Experiment     import Experiment
from .TTraceSet      import TTraceSet
from .VariableValues import VariableValues
from .TraceSetBlob   import TraceSetBlob
