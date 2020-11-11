
import os
import logging as log
import datetime
import ast

import numpy as np

from scipy.signal import butter
from scipy.signal import lfilter

import ldb

from ldb.records import StatisticTrace
from ldb.records import CorrolationTraces
from ldb.records import StatTraceType
from ldb.records import TraceSetBlob

from CaptureInterface import CaptureInterface

import scass

class AnalysisInterface(object):
    """
    Stores everything needed to be passed to an ExperimentFlow module to
    perform analysis of experiment results..

    Acts as a middle layer providing all boilerplate code that the
    ExperimentFlow modules might need, including ttest analysis, database
    object insertion and so on.
    """

    def __init__(self, database, target, experiment, force=False):
        self.database       = database
        self.experiment     = experiment
        self.target         = target
        self.force          = force


    def getVariableArrayFromTraceSet(self, traceSetBlob, variableName):
        """
        Return the VariableValues representing the variable inputs for a
        given trace set blob, or None if no such input variable exists
        in the database for the supplied trace set.
        """

        for inputVar in traceSetBlob.variableValues:
            if(inputVar.varname == variableName):
                return inputVar
            
        log.error("No input variable named '%s' associated with traceset ID=%d" % (variableName, traceSetBlob.id))

        return None

    def generateStatTraceName(self, traceSetBlob, name, variableName):
        tset_params = ast.literal_eval(traceSetBlob.parameters)
        pstr        = []
        for p in tset_params:
            pstr.append("%s=%s"%(p,tset_params[p]))
        pstr        = ", ".join(pstr)

        trace_name = "%s - %s %s: %s, %s" % (
            self.experiment.name, self.target.name,
            name,
            variableName,
            pstr
        )

        return trace_name

    def runHammingWeightAnalysis(self, traceSetBlob, variableName):
        """
        Run a hamming weight analysis on the variables used as inputs when
        generating the supplied traceset blob.
        """
        variable = self.getVariableArrayFromTraceSet(
            traceSetBlob, variableName
        )
        
        if(variable == None):
            return 1

        hw_inputs = variable.getValuesAsNdArray()

        hw_tracesset= traceSetBlob.getTracesAsNdArray()

        hw_trace    = scass.cpa.hammingWeightCorrolation(
            hw_tracesset, hw_inputs
        )

        corr_trace_name = self.generateStatTraceName(
            traceSetBlob, "Hamming Weight", variableName
        )

        self.insertCorrolationTrace(
            [traceSetBlob], [variable], hw_trace,
            corr_trace_name,
            ldb.records.StatTraceType.HW,
            ldb.records.CorrolationType.HAMMING_WEIGHT
        )

        return 0


    def runHammingDistanceAnalysis(self, traceSetBlob, var1Name, var2Name,tracename=None):
        """
        Run a hamming distance analysis on the variables used as inputs when
        generating the supplied traceset blob.
        var1/2Name  can be a string, in which case we search the database
        for the right variable values, or an np.ndarray, in which case
        we just operat on that array.
        """
        inputs1 = None
        inputs2 = None

        sourceVariables = []

        if(isinstance(var1Name,str)):
            variable1 = self.getVariableArrayFromTraceSet(
                traceSetBlob, var1Name
            )
            sourceVariables.append(variable1)
            inputs1 = variable1.getValuesAsNdArray()
        elif(isinstance(var1Name,np.ndarray)):
            inputs1 = var1Name
        else:
            assert False, "Unknown input variable type"
        
        if(isinstance(var2Name,str)):
            variable2 = self.getVariableArrayFromTraceSet(
                traceSetBlob, var2Name
            )
            sourceVariables.append(variable2)
            inputs2 = variable2.getValuesAsNdArray()
        elif(isinstance(var2Name,np.ndarray)):
            inputs2 = var2Name
        else:
            assert False, "Unknown input variable type"

        hd_tracesset= traceSetBlob.getTracesAsNdArray()

        hd_trace    = scass.cpa.hammingDistanceCorrolation(
            hd_tracesset, inputs1, inputs2
        )

        tn = tracename
        if(tn == None):
            tn = "%s+%s"%(var1Name,var2Name)
        
        corr_trace_name = self.generateStatTraceName(
                traceSetBlob, "Hamming Distance", tn
            )

        self.insertCorrolationTrace(
            [traceSetBlob], sourceVariables, hd_trace,
            corr_trace_name,
            ldb.records.StatTraceType.HD,
            ldb.records.CorrolationType.HAMMING_DISTANCE
        )

        return 0

    def byteToWordNdArray(nda):
        """
        Takes an (X,4) ND array of bytes and returns an (X,1) array
        of words.
        """
        assert(isinstance(nda, np.ndarray)),"Got %s" % type(nda)
        length, width = nda.shape
        assert(width == 4),"Array must be 4 bytes wide"
        assert(nda.dtype == np.uint8),"array must be unsigned bytes"

        newArray = np.empty((length,1),dtype=np.uint32)

        for i in range(0,length):
            newArray[i] = int.from_bytes(nda[i],"big")
        return newArray

    def opXor(self, traceSetBlob, var1Name, var2Name):
        """
        Return a numpy array representing the xor of corresponding
        variable values.
        """
        variable1 = self.getVariableArrayFromTraceSet(traceSetBlob, var1Name)
        variable2 = self.getVariableArrayFromTraceSet(traceSetBlob, var2Name)
        inputs1   = variable1.getValuesAsNdArray()
        inputs2   = variable2.getValuesAsNdArray()
        inputs1   = AnalysisInterface.byteToWordNdArray(inputs1)
        inputs2   = AnalysisInterface.byteToWordNdArray(inputs2)

        return np.bitwise_xor(inputs1, inputs2)


    def opAdd(self, traceSetBlob, var1Name, var2Name):
        """
        Return a numpy array representing the addition of corresponding
        variable values.
        """
        variable1 = self.getVariableArrayFromTraceSet(traceSetBlob, var1Name)
        variable2 = self.getVariableArrayFromTraceSet(traceSetBlob, var2Name)
        inputs1   = variable1.getValuesAsNdArray()
        inputs2   = variable2.getValuesAsNdArray()
        inputs1   = AnalysisInterface.byteToWordNdArray(inputs1)
        inputs2   = AnalysisInterface.byteToWordNdArray(inputs2)

        return np.add(inputs1,inputs2)

    def opRotateRight32(self, traceSetBlob, var1Name, ramt):
        """
        Return a numpy array representing the logical right rotation of 
        variable values.
        """
        variable1 = self.getVariableArrayFromTraceSet(traceSetBlob, var1Name)
        inputs1   = variable1.getValuesAsNdArray()
        inputs1   = AnalysisInterface.byteToWordNdArray(inputs1)
        
        return np.right_shift(inputs1, ramt) | np.left_shift(inputs1,32-ramt)

    def opShiftRight(self, traceSetBlob, var1Name, shamt):
        """
        Return a numpy array representing the logical right shift of 
        variable values.
        """
        variable1 = self.getVariableArrayFromTraceSet(traceSetBlob, var1Name)
        inputs1   = variable1.getValuesAsNdArray()
        inputs1   = AnalysisInterface.byteToWordNdArray(inputs1)

        return np.right_shift(inputs1, shamt)

    def opShiftLeft(self, traceSetBlob, var1Name, shamt):
        """
        Return a numpy array representing the logical left shift of 
        variable values.
        """
        variable1 = self.getVariableArrayFromTraceSet(traceSetBlob, var1Name)
        inputs1   = variable1.getValuesAsNdArray()

        return np.left_shift(inputs1, shamt)

        return inputs1


    def insertCorrolationTrace(self,
            inputTraceSets, inputVariables, trace, name, traceType, corrType
        ):
        """
        Creates StatisticTrace and CorrolationTraces records from the
        input parameters and commits them to the database
        """
            
        self.database.pushAutoCommit(False)

        inSetIds = set([s.id for s in inputTraceSets])
        inVarIds = set([v.id for v in inputVariables])

        pre_existing = self.database.getCorrolationTraceByAll (
            self.target.id, self.experiment.id, inSetIds, inVarIds, corrType,
            name
        )

        if(pre_existing == None):

            stat_trace  = StatisticTrace.fromTraceArray(trace, traceType)

            stat_trace.name = name

            corr_trace  = CorrolationTraces(
                name        = name,
                experiment  = self.experiment,
                target      = self.target,
                corrType    = corrType,
                statisticTrace = stat_trace,
                inputVariables  = inputVariables,
                inputTraceSets  = inputTraceSets 
            )

            self.database.insertCorrolationTrace(corr_trace)
            verb = "Inserted"

        elif(self.force):
            verb = "Updated"
            pre_existing.statisticTrace.setTraceValues(trace)
            
        else:
            verb = "Skipped"

        self.database.popAutoCommit()
        self.database.commit()

        log.info("%s corrolation trace: %s %s/%s/%s/%s" %(
            verb,
            name,
            self.experiment.fullname,
            self.target.name,
            corrType.name,
            ",".join([v.varname for v in inputVariables])
        ))


    def runTTestAnalyses(self, ttest):
        """
        Compute the T-Statistic trace for the supplied ttest object.
        If the trace already exists, it is not recomputed unless self.force
        is True
        """

        verb = "Skipped"

        if(ttest.tStatisticTrace == None or self.force):

            fixed_traces  = ttest.fixedTraceSet.getTracesAsNdArray()
            random_traces = ttest.randomTraceSet.getTracesAsNdArray()

            tt            = scass.ttest.TTest(fixed_traces, random_traces)

            if(ttest.tStatisticTrace == None):

                stat_trace  = StatisticTrace.fromTraceArray(
                    tt.ttrace,
                    ldb.records.StatTraceType.TTRACE
                )

                stat_trace.name = "%s - %s - TTrace, %s" % (
                    self.experiment.name,
                    self.target.name,
                    ttest.parameters
                )

                ttest.tStatisticTrace = stat_trace

                verb = "Inserted"

            else:

                verb = "Updated"

                ttest.tStatisticTrace.setTraceValues(tt.ttrace)

            self.database.commit()


        log.info("%s T-Statistic trace for TTest ID=%d" % (
            verb,
            ttest.id,
        ))

    
    def runAverageTraceForTraceSetBlob(self, traceset):
        """
        Compute the average trace for the supplied trace set and
        add it to the database.
        """
        existing = None
        verb     = "Skipped"

        for strace in traceset.statisticTraces:
            if(strace.stat_type == StatTraceType.AVG):
                existing = strace
                break

        if(existing == None or self.force):
            traces    = traceset.getTracesAsNdArray()
            avg_trace = np.mean(traces,axis=0)

            if(existing == None):
                verb = "Inserted"

                newtrace = StatisticTrace.fromTraceArray(
                    avg_trace, StatTraceType.AVG
                )
                newtrace.name = self.generateStatTraceName(
                    traceset,"Trace Set Avg Power",""
                )

                traceset.statisticTraces.append(newtrace)

            else:
                verb = "Updated"

                existing.setTraceValues(avg_trace)

            self.database.commit()

        log.info("%s average trace for Trace Set ID=%d" % (
            verb,
            traceset.id,
        ))


    def getStatTraceForTraceSetBlob(self, traceset,traceType):
        """
        Given a TraceSetBlob, return the first StatisticTrace
        object with the matching traceType, or None if it doesnt exist.
        """
        assert(isinstance(traceset, TraceSetBlob))

        for t in traceset.statisticTraces:
            if(t.stat_type == traceType):
                return t

        return None


    def getOrInsertAverageTrace(self, traceset):
        """
        Given a TraceSetBlob, return the average StatisticTrace
        object for it. If it doesn't exist, create it and return it.
        """
        assert(isinstance(traceset, TraceSetBlob))

        tr = self.getStatTraceForTraceSetBlob(traceset, StatTraceType.AVG)
        
        if(tr == None):
            self.runAverageTraceForTraceSetBlob(traceset)

        tr = self.getStatTraceForTraceSetBlob(traceset, StatTraceType.AVG)

        return tr


    def runFFTForTraceSetBlob(self, traceset):
        """
        Compute the discrete fourier transform for the average
        trace of the supplied trace set.
        """
        
        statTrace = self.getOrInsertAverageTrace(traceset)
        trace     = statTrace.getValuesAsNdArray()

        existing  = self.getStatTraceForTraceSetBlob(
            traceset, StatTraceType.FFT
        )

        toInsert  = None
        verb      = "Skipped"

        if(existing == None or self.force):

            fft_trace = np.fft.fft(trace)
            fft_trace = fft_trace[0:int(fft_trace.size/2)]

            if(existing == None):
                verb = "Inserted"
                existing = StatisticTrace.fromTraceArray(
                    fft_trace, StatTraceType.FFT
                )

                traceset.statisticTraces.append(existing)

            else:
                existing.setTraceValues(fft_trace)
                verb = "Updated"

            self.database.commit()
        
        log.info("%s FFT trace for Trace Set ID=%d" % (
            verb,
            traceset.id,
        ))


    def runAverageTraceForTTest(self, ttest):
        """
        Compute the average trace for the fixed and random
        trace sets for the supplied ttest
        """
        self.runAverageTraceForTraceSetBlob(ttest.fixedTraceSet)
        self.runAverageTraceForTraceSetBlob(ttest.randomTraceSet)

    def runFFTForTTest(self, ttest):
        """
        Compute the discrete Fourier Transform for the average
        trace of the fixed and random trace set blobs of the
        supplied ttest.
        """
        self.runFFTForTraceSetBlob(ttest.fixedTraceSet)
        self.runFFTForTraceSetBlob(ttest.randomTraceSet)


    def getTTestsForTargetAndExperiment(self):
        return self.database.getTTraceSetsByTargetAndExperiment(
            self.target.id, self.experiment.id
        )

    def getTraceSetBlobsForTargetAndExperiment(self):
        """
        Returns all trace set blob records which still have their
        trace data included.
        """
        return self.database.getTraceSetBlobByTargetAndExperiment(
            self.target.id, self.experiment.id
        ).filter(TraceSetBlob.traces!=None)

    def runDefaultAnalysis(self):
        """
        Run the defualt set of analyses on the given experiment+target
        combination and place the results in the database.
        """

        ttest_sets = self.getTTestsForTargetAndExperiment()

        for ttest in ttest_sets:
            self.runTTestAnalyses(ttest)
            self.runAverageTraceForTTest(ttest)
            self.runFFTForTTest(ttest)

            for variable in ttest.randomTraceSet.variableValues:

                if(variable.is_ttest_var or variable.is_randomisable):
                    self.runHammingWeightAnalysis(
                        ttest.randomTraceSet,
                        variable.varname
                    )


    def convertArrayBytesToInt(self, array):
        """
        Convert a Nx4 array of bytes into an Nx1 array of ints.
        """
        length,width = array.shape
        assert(width == 4)
        assert(array.dtype == np.uint8)

        new_array = np.empty((length, 1),dtype=np.uint32)
        for row in range(0, length):
            new_array[row] = int.from_bytes(array[row],"big")

        return new_array
