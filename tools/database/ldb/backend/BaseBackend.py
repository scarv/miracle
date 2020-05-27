
import logging as log

import sqlalchemy

from ..records import Device
from ..records import Board
from ..records import Core
from ..records import Target
from ..records import Experiment
from ..records import TTraceSet
from ..records import TraceSetBlob
from ..records import VariableValues
from ..records import StatisticTrace
from ..records import CorrolationTraces
from ..records import ProgramBinary

class BaseBackend(object):
    """
    Class from which all other backends are derived. Provides the base
    interface which all backend classes must provide.
    """

    def __init__(self, path, autocommit=False):
        """
        Create a new connection to a database
        """
        self._engine        = sqlalchemy.create_engine(path)
        self._SessionMaker  = sqlalchemy.orm.sessionmaker(bind=self._engine)
        self._session       = self._SessionMaker()

        self._autocommit    = [autocommit]

    def close(self):
        self._session.close()

    @property
    def autocommit(self):
        """
        Automatically commit everything to the database after every call
        to an insert/update/remove function
        """
        return self._autocommit[0]

    @autocommit.setter
    def autocommit(self, value):
        self._autocommit[0] = value


    def pushAutoCommit(self,ac):
        self._autocommit.insert(0,ac)

    def popAutoCommit(self):
        if(len(self._autocommit) > 1):
            self._autocommit.pop(0)
        else:
            pass


    def _handleAutocommit(self):
        """
        Called at the end of each insert/remove/update function to
        handle automatic comitting of pending operations.
        """
        if(self._autocommit):
            self.commit()


    def commit(self):
        """
        Commit pending operations to the database
        """
        self._session.commit()


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
        self._session.add(device)
        self._handleAutocommit()
        return None


    def insertBoard(self, board):
        """
        Insert a new board into the database, as described by the
        board parameter.

        :returns: None
        """
        self._session.add(board)
        self._handleAutocommit()
        return None


    def insertCore(self, cpu ):
        """
        Insert a new Core into the database, as described by the
        cpu parameter.

        :returns: None
        """
        self._session.add(cpu)
        self._handleAutocommit()
        return None


    def insertTarget(self, target):
        """
        Insert a new target device into the database, as described by the
        target parameter.

        :returns: None
        """
        self._session.add(target)
        self._handleAutocommit()
        return None


    def insertExperiment(self, experiment):
        """
        Insert a new experiment into the database, as described by the
        experiment parameter.

        :returns: None
        """
        self._session.add(experiment)
        self._handleAutocommit()
        return None


    def insertTTraceSet(self, ttraceset):
        """
        Insert a new ttraceset into the database, as described by the
        ttraceset parameter.

        :returns: None
        """
        self._session.add(ttraceset)
        self._handleAutocommit()
        return None


    def insertTraceSetBlob(self, tracesetblob):
        """
        Insert a new TraceSetBlob into the database, as described by the
        tracesetblob parameter.

        :returns: None
        """
        self._session.add(tracesetblob)
        self._handleAutocommit()
        return None


    def insertProgramBinary(self, binary):
        """
        Insert a new program binary into the database.
        """
        self._session.add(binary)
        self._handleAutocommit()
        return None


    def insertVariableValues(self, variableValues):
        """
        Insert a new VariableValues set into the database, as described by the
        variableValues parameter.

        :returns: None
        """
        self._session.add(variableValues)
        self._handleAutocommit()
        return None


    def insertCorrolationTrace(self, corrolationTrace):
        """
        Insert a new CorrolationTraces object into the database, as described
        by the corrolationTrace parameter.

        :returns: None
        """
        self._session.add(corrolationTrace)
        self._handleAutocommit()
        return None


    def getAllDevices(self):
        """
        Return an iterator which will iterate through all devices
        in the database.
        """
        return self._session.query(Device).order_by(Device.id)


    def getAllBoards(self):
        """
        Return an iterator which will iterate through all boards 
        in the database.
        """
        return self._session.query(Board).order_by(Board.id)


    def getAllCores(self):
        """
        Return an iterator which will iterate through all cores
        in the database.
        """
        return self._session.query(Core).order_by(Core.id)


    def getAllTargets(self):
        """
        Return an iterator which will iterate through all targets
        in the database.
        """
        return self._session.query(Target).order_by(Target.id)


    def getAllStatisticTraces(self):
        """
        Return an iterator which will iterate through all statistic traces 
        in the database.
        """
        return self._session.query(StatisticTrace).order_by(StatisticTrace.id)


    def getAllExperiments(self):
        """
        Return an iterator which will iterate through all experiments
        in the database.
        """
        return self._session.query(Experiment).order_by(Experiment.id)


    def getAllTTraceSets(self):
        """
        Return an iterator which will iterate through all TTraceSet objects
        in the database.
        """
        return self._session.query(TTraceSet).order_by(TTraceSet.id)


    def getAllTraceSetBlobs(self):
        """
        Return an iterator which will iterate through all TraceSetBlob objects
        in the database.
        """
        return self._session.query(TraceSetBlob).order_by(TraceSetBlob.id)


    def getAllVariableValues(self):
        """
        Return an iterator which will iterate through all VariableValues
        objects in the database.
        """
        return self._session.query(VariableValues).order_by(VariableValues.id)


    def getAllCorrolationTraces(self):
        """
        Return an iterator which will iterate through all CorrolationTraces
        objects in the database.
        """
        return self._session.query(CorrolationTraces).order_by(CorrolationTraces.id)


    def getDeviceById(self, deviceId):
        """
        Return an instance of the Device class from the database with
        the supplied deviceId.

        :returns: None or Device
        """
        return self._session.query(Device).filter_by(id=deviceId).one_or_none()


    def getBoardById(self, boardId):
        """
        Return an instance of the Board class from the database with
        the supplied boardId.

        :returns: None or Board
        """
        return self._session.query(Board).filter_by(id=boardId).one_or_none()


    def getCoreById(self, coreId):
        """
        Return an instance of the Core class from the database with
        the supplied coreId.

        :returns: None or Core
        """
        return self._session.query(Core).filter_by(id=coreId).one_or_none()


    def getTargetById(self, targetId):
        """
        Return an instance of the Target class from the database with
        the supplied targetId.

        :returns: None or Target 
        """
        return self._session.query(Target).filter_by(id=targetId).one_or_none()


    def getDeviceByName(self, deviceName):
        """
        Return an instance of the Device class from the database with
        the supplied deviceName.

        :returns: None or Device
        """
        return self._session.query(Device).filter_by(name=deviceName).first()


    def getBoardByName(self, boardName):
        """
        Return an instance of the Board class from the database with
        the supplied boardName.

        :returns: None or Board
        """
        return self._session.query(Board).filter_by(name=boardName).first()


    def getCoreByName(self, coreName):
        """
        Return an instance of the Core class from the database with
        the supplied coreName.

        :returns: None or Core
        """
        return self._session.query(Core).filter_by(name=coreName).first()


    def getTargetByName(self, targetName):
        """
        Return an instance of the Target class from the database with
        the supplied targetName.

        :returns: None or Target 
        """
        return self._session.query(Target).filter_by(name=targetName).first()
    

    def getExperimentById(self, experimentId):
        """
        Return an instance of the Experiment class from the database with
        the supplied experimentId.

        :returns: None or Experiment
        """
        return self._session.query(Experiment).filter_by(id=experimentId).one_or_none()
    
    
    def getStatisticTraceById(self, sid):
        """
        Return an instance of the StatisticTrace class from the database with
        the supplied sid.

        :returns: None or StatisticTrace
        """
        return self._session.query(StatisticTrace).filter_by(id=sid).one_or_none()


    def getTargetsByDevice(self, deviceId):
        """
        Return all of the targets where deviceid matches the supplied deviceId 
        """
        return self._session.query(Target).filter_by(deviceid=deviceId).all()


    def getTargetsByCore(self, coreId):
        """
        Return all of the targets where coreid matches the supplied coreId
        """
        return self._session.query(Target).filter_by(coreid=coreId).all()


    def getTargetsByBoard(self, boardId):
        """
        Return all of the targets where boardid matches the supplied boardId
        """
        return self._session.query(Target).filter_by(boardid=boardId).all()
    

    def getExperimentsByTarget(self, targetId):
        """
        Return the set of experiments for which there are results
        corresponding to the supplied targetId
        """
        eids = self._session.query(TraceSetBlob.experimentId).filter_by(
                targetId = targetId).distinct().all()
        eids = [x[0] for x in eids]
        return self._session.query(Experiment).filter(Experiment.id.in_(eids))


    def getExperimentCountByTarget(self, targetId):
        """
        Return the number of experiments for which there are results
        corresponding to the supplied ID.
        """
        eids = self._session.query(TraceSetBlob.experimentId).filter_by(
                targetId = targetId).distinct().all()
        return len(eids)


    def getTargetsByExperiment(self, experimentId):
        """
        Return the set of targets for which there are results
        corresponding to the supplied experimentId 
        """
        tids = self._session.query(TraceSetBlob.targetId).filter_by(
                experimentId = experimentId).distinct().all()
        tids = [x[0] for x in tids]
        return self._session.query(Target).filter(Target.id.in_(tids))


    def getExperimentByCatagoryAndName(self, catagory, name):
        """
        Return an instance of the Experiment class from the database
        which has the supplied catagory and name values.

        :returns: None or Experiment
        """
        return self._session.query(Experiment).filter_by(
            catagory = catagory,
            name     = name
        ).first()


    def getTTraceSetsById(self, ttraceSetId):
        """
        Return an instance of the TTraceSet class from the database with
        the supplied ttraceSetId.

        :returns: None or TTraceSet
        """
        return self._session.query(TTraceSet).filter_by(
            id=ttraceSetId
        ).one_or_none()


    def getTTraceSetsByTargetAndExperiment(self, targetId, experimentId):
        """
        Return the set of TTraces matching the supplied target and experiment
        ids.
        """
        return self._session.query(TTraceSet).filter_by(
            targetId     = targetId,
            experimentId = experimentId
        )


    def getCorrolationTraceByTargetAndExperiment(self, targetId, experimentId):
        """
        Return the set of CorrolationTraces matching the supplied target and
        experiment ids.
        """
        return self._session.query(CorrolationTraces).filter_by(
            targetId     = targetId,
            experimentId = experimentId
        )


    def getTraceSetBlobById(self, traceSetBlobId):
        """
        Return the tracesetBlob object with the supplied ID
        """
        return self._session.query(TraceSetBlob).filter_by(
            id=traceSetBlobId
        ).one_or_none()
    
    
    def getCorrolationTraceById(self, corrolationTraceId):
        """
        Return the CorrolationTraces object with the supplied ID
        """
        return self._session.query(CorrolationTraces).filter_by(
            id=corrolationTraceId
        ).one_or_none()


    def getCorrolationTraceByAll(self,
        targetId, experimentId, inputTraceSetIds, inputVarIds, corrType
        ):
        """
        Tries to find a corrolation trace corresponding to all of the
        supplied inputs. Returns it if found, otherwise None
        """

        q = self._session.query(CorrolationTraces).filter(
            sqlalchemy.and_(
                CorrolationTraces.targetId      == targetId,
                CorrolationTraces.experimentId  == experimentId,
                CorrolationTraces.corrType      == corrType
            )
        )

        for candidate in q.all():

            inSetIds = set([b.id for b in candidate.inputTraceSets])

            if(inSetIds == inputTraceSetIds):
                
                inVarIds = set([v.id for v in candidate.inputVariables])

                if(inVarIds == inputVarIds):
                    return candidate

        return None


    def getProgramBinaryById(self, pid):
        pbin = self._session.query(ProgramBinary).filter_by(
            id =pid
        )
        return pbin.first()

    def getProgramBinaryByTargetAndExperiment(self, tgtId, expId):
        """
        Return all program binaries corresponding to the supplied
        target and experiment ID.
        """
        pbin = self._session.query(ProgramBinary).filter (
            sqlalchemy.and_(
                ProgramBinary.targetId      == tgtId,
                ProgramBinary.experimentId  == expId
            )
        )
        return pbin.first()
        

    def removeProgramBinary(self, pbin):
        """
        Delete the specified program binary from the database.
        """
        self._session.delete(pbin)
        self._handleAutocommit()


    def removeTTraceSet(self, ttraceSetId):
        """
        Remove the ttraceset and associated traceset blobs
        """
        log.info("Remove TTraceset with ID=%d" % ttraceSetId)

        ttraceSet = self.getTTraceSetsById(ttraceSetId)

        self._session.delete(ttraceSet)

        self._handleAutocommit()


    def removeTraceSetBlob(self, traceSetBlobId):
        """
        Remove the ttracesetblob with the supplied id
        Will also automatically remove VariableValues entries which are
        no longer linked too by a TraceSetBlob
        """
        log.info("Remove TraceSetBlob with ID=%d" % traceSetBlobId)

        traceSetBlob = self.getTraceSetBlobById(traceSetBlobId)

        self._session.delete(traceSetBlob)

        self._handleAutocommit()
    
    
    def removeCorrolationTrace(self, corrolationTraceId):
        """
        Remove the corrolationTrace with the supplied id
        Will also automatically remove statistic trace entries which are
        no longer linked too.
        """
        log.info("Remove CorrolationTrace ID=%d" % corrolationTraceId)

        to_remove = self.getCorrolationTraceById(corrolationTraceId)

        self._session.delete(to_remove)

        self._handleAutocommit()


    def removeDevice(self, deviceId):
        """
        Remove the device from the database with the supplied Id,
        along with all experimental data from the database which
        points to that device.
        """
        assert(False)

        self._handleAutocommit()
        return None


    def removeBoard(self, boardId):
        """
        Remove the board from the database with the supplied Id,
        along with all experimental data from the database which
        points to that board.
        """
        assert(False)

        self._handleAutocommit()
        return None


    def removeCore(self, coreId):
        """
        Remove the Core from the database with the supplied Id,
        along with all experimental data from the database which
        points to that Core.
        """
        assert(False)

        self._handleAutocommit()
        return None


    def removeTarget(self, targetId):
        """
        Remove the target from the database with the supplied Id,
        along with all experimental data from the database which
        points to that target.
        """
        assert(False)

        self._handleAutocommit()
        return None

    
    def removeExperiment(self, experimentId):
        """
        Remove the experiment from the database with the supplied Id,
        along with all experimental data from the database which
        points to that experiment.
        """

        tracesets = self._session.query(TTraceSet).filter_by(
            experimentId = experimentId
        ).all()

        for t in tracesets:
            log.info("Remove ttrace id=%d" % t.id)
            self._session.delete(t)

        corrtraces = self._session.query(CorrolationTraces).filter_by(
            experimentId = experimentId
        ).all()
        
        for t in corrtraces:
            log.info("Remove corrolation trace id=%d" % t.id)
            self._session.delete(t)

        experiment = self.getExperimentById(experimentId)
        
        log.info("Remove experiment id=%d" % experiment.id)

        self._session.delete(experiment)
        
        self._handleAutocommit()
        return None

