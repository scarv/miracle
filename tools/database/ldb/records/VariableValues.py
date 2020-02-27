
import io
import logging as log
import datetime

import numpy as np

from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, Enum, Binary

from . import Base
from . import TraceCompression
from . import compressNDArray
from . import decompressNDArray

class VariableValues(Base):
    """
    Represents a set of variables used as inputs (or outputs) to a TTest.
    Stored as a 1D numpy array.
    """

    __tablename__ = "variable_values"

    id          = Column(Integer, primary_key=True)
    compression = Column(Enum(TraceCompression), default = TraceCompression.NONE)
    varname     = Column(String, nullable = False)
    num_values  = Column(Integer, default = 0)
    values_bin  = Column(Binary)

    is_input    = Column(Boolean, nullable=False)
    is_output   = Column(Boolean, nullable=False)
    is_randomisable = Column(Boolean, nullable=False)
    is_ttest_var= Column(Boolean, nullable=False)
    
    @property
    def is_fixed(self):
        return (self.is_input and not self.is_randomisable)

    def __repr__(self):
        return "%5d, %20s, %s, %5d" % (
            self.id, self.varname, self.compression, self.num_values
        )

    def fromValuesArray(name, values, compression = TraceCompression.GZIP):
        """
        Create a new VariableValues object from the supplied values with the
        specified compression, ready for insertion into the database.
        """
        assert(isinstance(values, np.ndarray))

        tr = VariableValues(
            varname      = name,
        )
        tr.setVariableValues(values, compression = compression)

        return tr

    def getValuesAsNdArray(self):
        """
        Return the decompressed values of this blob as a numpy.NdArray.
        """
        return decompressNDArray(self.values_bin,self.compression)

    def setVariableValues(self, values, compression = TraceCompression.NONE):
        """
        Set the values_bin field of the record, compressing as needed, and
        update the num_values field
        """
        assert(isinstance(values, np.ndarray))
        
        self.num_values = values.shape[0]
        self.values_bin = compressNDArray(values, compression)
        
        assert(len(self.values_bin) > 0),"Valuesdata length  = 0"

        self.compression= compression

