
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

TRACE_COMPRESSION_NONE  = "none"
TRACE_COMPRESSION_GZ    = "gz"

TRACE_COMPRESSION = [
    TRACE_COMPRESSION_NONE,
    TRACE_COMPRESSION_GZ
]

STAT_TYPE_TTRACE        = "ttrace"
STAT_TYPE_AVG           = "avg"
STAT_TYPE_STD           = "std"
STAT_TYPE_MIN           = "min"
STAT_TYPE_MAX           = "max"
STAT_TYPE_RNG           = "rng"
STAT_TYPE_HW            = "hw"
STAT_TYPE_HD            = "hd"

STAT_TRACE_TYPES        = [
    STAT_TYPE_TTRACE,
    STAT_TYPE_AVG   ,
    STAT_TYPE_STD   ,
    STAT_TYPE_MIN   ,
    STAT_TYPE_MAX   ,
    STAT_TYPE_RNG   ,
    STAT_TYPE_HW    ,
    STAT_TYPE_HD    
]

from .Device         import Device
from .Board          import Board
from .Core           import Core
from .Target         import Target
from .Experiment     import Experiment
from .TraceSet       import TraceSet
from .StatisticTrace import StatisticTrace
