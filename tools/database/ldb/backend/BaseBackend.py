
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


    def insertBoard(self, board):
        """
        Insert a new board into the database, as described by the
        board parameter.

        :returns: None
        """

        return None
    

    def insertCPU(self, cpu ):
        """
        Insert a new CPU into the database, as described by the
        cpu parameter.

        :returns: None
        """

        return None

    def insertTarget(self, target):
        """
        Insert a new target device into the database, as described by the
        target parameter.

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


    def getBoardById(self, boardId):
        """
        Return an instance of the Board class from the database with
        the supplied boardId.

        :returns: None or Board
        """

        return None


    def getCPUById(self, cpuId):
        """
        Return an instance of the CPU class from the database with
        the supplied cpuId.

        :returns: None or CPU
        """

        return None


    def getTargetById(self, targetId):
        """
        Return an instance of the Target class from the database with
        the supplied targetId.

        :returns: None or Target 
        """

        return None


    def getDeviceByName(self, deviceName):
        """
        Return an instance of the Device class from the database with
        the supplied deviceName.

        :returns: None or Device
        """

        return None


    def getBoardByName(self, boardName):
        """
        Return an instance of the Board class from the database with
        the supplied boardName.

        :returns: None or Board
        """

        return None


    def getCPUByName(self, cpuName):
        """
        Return an instance of the CPU class from the database with
        the supplied cpuName.

        :returns: None or CPU
        """

        return None


    def getTargetByName(self, targetName):
        """
        Return an instance of the Target class from the database with
        the supplied targetName.

        :returns: None or Target 
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


    def removeBoard(self, boardId):
        """
        Remove the board from the database with the supplied Id,
        along with all experimental data from the database which
        points to that board.
        """

        return None


    def removeCPU(self, cpuId):
        """
        Remove the CPU from the database with the supplied Id,
        along with all experimental data from the database which
        points to that CPU.
        """

        return None


    def removeTarget(self, targetId):
        """
        Remove the target from the database with the supplied Id,
        along with all experimental data from the database which
        points to that target.
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


