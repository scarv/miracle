
from sqlalchemy import Column, Integer, String

from . import Base

class StatisticTrace(Base):
    """
    Represents a single statistic trace for a given experiment and
    device pair.
    """

    __tablename__ = "statistic_traces"

    id      = Column(Integer, primary_key=True)
    filepath= Column(String)

