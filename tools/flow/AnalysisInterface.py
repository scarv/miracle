
import os
import logging as log
import datetime

import ldb

from ldb.records import StatisticTrace
from ldb.records import CorrolationTraces

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

        return None


    def runHammingWeightAnalysis(self, traceSetBlob, variableName):
        """
        Run a hamming weight analysis on the variables used as inputs when
        generating the supplied traceset blob.
        """
        variable = self.getVariableArrayFromTraceSet(
            traceSetBlob, variableName
        )
        
        if(variable == None):
            log.error("No input variable named '%s' associated with traceset ID=%d" % (variableName, traceSetBlob.id))
            return 1

        hw_inputs = variable.getValuesAsNdArray()

        hw_tracesset= traceSetBlob.getTracesAsNdArray()

        hw_trace    = scass.cpa.hammingWeightCorrolation(
            hw_tracesset, hw_inputs
        )

        corr_trace_name = ""

        self.insertCorrolationTrace(
            [traceSetBlob], [variable], hw_trace,
            corr_trace_name,
            ldb.records.StatTraceType.HW,
            ldb.records.CorrolationType.HAMMING_WEIGHT
        )

        return 0


    def runHammingDistanceAnalysis(self, traceSetBlob, var1Name, var2Name):
        """
        Run a hamming distance analysis on the variables used as inputs when
        generating the supplied traceset blob.
        """
        variable1 = self.getVariableArrayFromTraceSet(
            traceSetBlob, var1Name
        )

        if(variable1 == None):
            log.error("No input variable named '%s' associated with traceset ID=%d" % (var1Name, traceSetBlob.id))
            return 1
        
        variable2 = self.getVariableArrayFromTraceSet(
            traceSetBlob, var2Name
        )

        if(variable2 == None):
            log.error("No input variable named '%s' associated with traceset ID=%d" % (var2Name, traceSetBlob.id))
            return 1

        inputs1 = variable1.getValuesAsNdArray()
        inputs2 = variable2.getValuesAsNdArray()

        hd_tracesset= traceSetBlob.getTracesAsNdArray()

        hd_trace    = scass.cpa.hammingDistanceCorrolation(
            hd_tracesset, inputs1, inputs2
        )
        
        corr_trace_name = ""

        self.insertCorrolationTrace(
            [traceSetBlob], [variable1,variable2], hd_trace,
            corr_trace_name,
            ldb.records.StatTraceType.HD,
            ldb.records.CorrolationType.HAMMING_DISTANCE
        )

        return 0

    def insertCorrolationTrace(self,
            inputTraceSets, inputVariables, trace, name, traceType, corrType
        ):
        """
        Creates StatisticTrace and CorrolationTraces records from the
        input parameters and commtis them to the database
        """
            
        self.database.pushAutoCommit(False)

        inSetIds = set([s.id for s in inputTraceSets])
        inVarIds = set([v.id for v in inputVariables])

        pre_existing = self.database.getCorrolationTraceByAll (
            self.target.id, self.experiment.id, inSetIds, inVarIds, corrType
        )

        if(pre_existing == None):

            stat_trace  = StatisticTrace.fromTraceArray(trace, traceType)

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

        log.info("%s corrolation trace: %s/%s/%s/%s" %(
            verb,
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

    def getTTestsForTargetAndExperiment(self):
        return self.database.getTTraceSetsByTargetAndExperiment(
            self.target.id, self.experiment.id
        )

    def runDefaultAnalysis(self):
        """
        Run the defualt set of analyses on the given experiment+target
        combination and place the results in the database.
        """

        ttest_sets = self.getTTestsForTargetAndExperiment()

        for ttest in ttest_sets:
            self.runTTestAnalyses(ttest)

            for variable in ttest.randomTraceSet.variableValues:

                if(variable.is_ttest_var or variable.is_randomisable):
                    self.runHammingWeightAnalysis(
                        ttest.randomTraceSet,
                        variable.varname
                    )

