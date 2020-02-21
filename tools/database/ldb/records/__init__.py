
import enum

from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class TraceCompression(enum.Enum):
    NONE    = 1
    GZIP    = 2

class StatTraceType(enum.Enum):
    TTRACE  = 0
    AVG     = 1
    STD     = 2
    MIN     = 3
    MAX     = 4
    RNG     = 5
    HW      = 6
    HD      = 7

from .Device         import Device
from .Board          import Board
from .Core           import Core
from .Target         import Target
from .Experiment     import Experiment
from .TTraceSet      import TTraceSet
from .TraceSetBlob   import TraceSetBlob
