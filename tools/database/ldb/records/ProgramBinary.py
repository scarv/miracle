
import io
import logging as log

import numpy as np

from sqlalchemy import Column, Integer, String, ForeignKey, Text, Binary, Table
from sqlalchemy.orm import relationship

from . import Base

program_binary_target_association = Table (
    "program_binary_target_association", Base.metadata,
    Column("programId", Integer, ForeignKey("program_binaries.id")),
    Column("targetId", Integer, ForeignKey("targets.id"))
)

class ProgramBinary(Base):
    """
    Table for storing program binaries and their disassembly used
    to capture trace sets.
    """

    __tablename__   = "program_binaries"

    id              = Column(Integer, primary_key=True)
    binary          = Column(Binary)
    disasm          = Column(Text)

    experimentId= Column(Integer,ForeignKey("experiments.id"),nullable=False)
    targetId    = Column(Integer,ForeignKey("targets.id"),nullable=False)
    
    target      = relationship("Target")
    experiment  = relationship("Experiment")
