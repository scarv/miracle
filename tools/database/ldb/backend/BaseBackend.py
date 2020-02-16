
from ..records import Device
from ..records import Experiment
from ..records import TraceSet
from ..records import StatisticTrace

class BaseBackend(object):
    """
    Class from which all other backends are derived. Provides the base
    interface which all backend classes must provide.
    """

    def __init__(self):
        """
        Create a new connection to a database
        """


    def createNew(path):
        """
        Creates a new database, as per the records schema.

        Returns True if everything was successful, else False
        """


    def insertDevice(self, device):
        """
        Insert a new device into the database, as described by the
        device parameter.

        :returns: None
        """

        return None


    def insertExperiment(self, experiment):
        """
        Insert a new experiment into the database, as described by the
        experiment parameter.

        :returns: None
        """

        return None

    
    def insertTraceSet(self, traceSet):
        """
        Insert a new traceSet into the database, as described by the
        traceSet parameter.

        :returns: None
        """

        return None


    def insertStatisticTrace(self, statisticTrace):
        """
        Insert a new statisticTrace into the database, as described by the
        statisticTrace parameter.

        :returns: None
        """

        return None


    def getDeviceById(self, deviceId):
        """
        Return an instance of the Device class from the database with
        the supplied deviceId.

        :returns: None or Device
        """

        return None
    

    def getExperimentById(self, experimentId):
        """
        Return an instance of the Experiment class from the database with
        the supplied experimentId.

        :returns: None or StatisticTrace
        """

        return None

    
    def getTraceSetById(self, traceSetId):
        """
        Return an instance of the TraceSet class from the database with
        the supplied traceSetId.

        :returns: None or StatisticTrace 
        """

        return None


    def getStatisticTraceById(self, statisticTraceId):
        """
        Return an instance of the StatisticTrace class from the database with
        the supplied statisticTraceId.

        :returns: None or StatisticTrace 
        """

        return None


    def removeDevice(self, deviceId):
        """
        Remove the device from the database with the supplied Id,
        along with all experimental data from the database which
        points to that device.
        """

        return None

    
    def removeExperiment(self, experimentId):
        """
        Remove the experiment from the database with the supplied Id,
        along with all experimental data from the database which
        points to that experiment.
        """

        return None
    
    
    def removeTraceSet(self, traceSetId):
        """
        Remove the traceSet from the database with the supplied Id,
        along with all statistic traces which are derived from it.
        """

        return None

    
    def removeStatisticTrace(self, statisticTraceId):
        """
        Remove the statistic from the database with the supplied Id
        """

        return None


