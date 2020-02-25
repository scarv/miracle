
import io
import logging as log
import datetime

import numpy as np

from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, Enum, Binary, Table
from sqlalchemy.orm import relationship

from . import Base
from . import TraceCompression
from . import CorrolationType
from . import StatTraceType
from . import compressNDArray
from . import decompressNDArray

corrolation_trace_var_values_association = Table (
    "corrolation_trace_var_values_association", Base.metadata,
    Column("corrolationTraceId", Integer, ForeignKey("corrolation_traces.id")),
    Column("variableValuesId", Integer, ForeignKey("variable_values.id"))
)

class CorrolationTraces(Base):
    """
    Represents corrolation analysis based traces. Be they hamming weight,
    hamming distance or specialist leakage model functions.
    """

    __tablename__ = "corrolation_traces"

    id          = Column(Integer, primary_key=True)
    name        = Column(String)
    experimentId= Column(Integer,ForeignKey("experiments.id"),nullable=False)
    targetId    = Column(Integer,ForeignKey("targets.id"),nullable=False)
    corrType    = Column(Enum(CorrolationType),nullable=False)

    statisticTraceid = Column(Integer,
        ForeignKey("statistic_traces.id"),nullable=False)

    statisticTrace  = relationship("StatisticTrace",
        single_parent   = True,
        cascade         = "all, delete-orphan"
    )

    inputVariables  = relationship("VariableValues",
        cascade     = "all",
        secondary   = corrolation_trace_var_values_association
    )

