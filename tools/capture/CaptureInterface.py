
import os
import logging as log
import datetime

import ldb

from ldb.records import TraceSetBlob

import scass

class CaptureInterface(object):
    """
    Stores everything needed to be passed to an ExperimentFlow module.

    Acts as a middle layer providing all boilerplate code that the
    ExperimentFlow modules might need, including ttest setup, database
    object insertion and so on.
    """

    def __init__(self,
            cmd_args, scope, target_name, comms, database, work_dir):
        self.cmd_args            = cmd_args
        self.target_name         = target_name
        self.target_comms        = comms
        self.scope               = scope
        self.database            = database
        self.num_ttest_traces    = self.cmd_args.ttest_traces
        self.scope_power_channel = None
        self.trigger_window_size = None
        self.original_work_dir   = work_dir
        self.work_dir            = work_dir

    def createTTestCaptureClass(self, variable_values = {}):
        """
        Boilerplate code for creating a ttest capture object and
        setting it up with the right input variable values.
        """
        
        tt_traces = None #os.path.join(self.work_dir,"traces.npy.gz")
        tt_fixed  = None #os.path.join(self.work_dir,"fixed.npy.gz")

        ttest = scass.ttest.TTestCapture(
            self.target_comms,
            self.scope,
            self.scope.trigger_channel,
            self.scope_power_channel,
            tt_traces,
            tt_fixed,
            self.num_ttest_traces,
            self.trigger_window_size
        )
        
        ttest.zeros_as_fixed_value = True
        
        # Must be called before we start setting input values.
        ttest.initialiseTTest()
        
        for vname in variable_values:
            vvalue = variable_values[vname]
            var = ttest.getVariableByName(vname)
            var.setFixedValue(vvalue.to_bytes(var.size,byteorder="little"))
            var.takeFixedValue()

        return ttest


    def runAndInsertTTest(self,
            experiment_catagory,
            experiment_name,
            variable_values
        ):
        """
        Create a TTestCapture class using createTTestCaptureClass,
        run the ttest and insert the results into self.database
        """
        assert(isinstance(experiment_catagory,str))
        assert(isinstance(experiment_name,str))
        assert(isinstance(variable_values,dict))

        self.target_comms.doInitExperiment()

        ttest = self.createTTestCaptureClass(variable_values=variable_values)

        ttest.performTTest()

        dbinsert_result = self.dbInsertTTestTraceSet(
            ttest,
            experiment_catagory,
            experiment_name
        )

        return dbinsert_result


    def dbGetOrInsertExperiment(self, experiment_catagory, experiment_name):
        """
        If no experiment with the supplied catagory/name exists, then
        add it to the database and return the record.
        """
        record = self.database.getExperimentByCatagoryAndName(
            experiment_catagory, experiment_name
        )

        if(record == None):
            log.warning("Experiment '%s/%s' not in database. Inserting now." %(
                experiment_catagory, experiment_name
            ))

            record = ldb.records.Experiment(
                name = experiment_name,
                catagory = experiment_catagory
            )

            self.database.insertExperiment(record)
            self.database.commit()

        return record


    def createParamStringFromTTest(ttest):
        """
        Creates a string representation of ttest parameter values
        """
        param_dict      = {}

        for var in ttest.tgt_vars:
            if(var.is_input and not var.is_ttest_variable and not var.is_randomisable):
                param_dict[var.name] = var.fixed_value

        param_str       = str(param_dict)

        return param_str

    def dbInsertTTestTraceSet(self, 
                              ttest,
                              experiment_catagory,
                              experiment_name,
                              overwrite = True):
        """
        Adds a ttest trace set record into the database. Deletes any
        existing databases which already exist with the same matching
        credentials.
        """
        self.database.pushAutoCommit(False)

        db_experiment   = self.dbGetOrInsertExperiment(
            experiment_catagory, experiment_name
        )

        db_target       = self.database.getTargetByName(self.target_name)
        
        if(db_target == None):
            log.error("No such target in database: '%s'" % (
                self.target_name
            ))
            return 1
        
        param_str = CaptureInterface.createParamStringFromTTest(ttest)

        pre_existing = self.database.getTTraceSetsByTargetAndExperiment (
            db_target.id, db_experiment.id
        ).filter_by(parameters = param_str)

        if(pre_existing.count() > 1):
            log.error("Multiple existing TTraceSet entries for %s - %s/%s" %(
                db_target.name, db_experiment.catagory, db_experiment.name
            ))
            return 1

        elif(pre_existing.count() == 1 and not overwrite):
            log.error("Pre-existing TTraceSet entry for %s - %s/%s" %(
                db_target.name, db_experiment.catagory, db_experiment.name
            ))
            return 1

        elif(pre_existing.count() == 1 and overwrite):
            # Delete the old trace sets ready for updating
            log.warn("Removed pre-existing ttrace set.")
            self.database.removeTTraceSet(pre_existing.first().id)
        

        ts_fixed    = TraceSetBlob.fromTraces(ttest.getFixedTraces())
        ts_rand     = TraceSetBlob.fromTraces(ttest.getRandomTraces())

        self.database.insertTraceSetBlob(ts_fixed)
        self.database.insertTraceSetBlob(ts_rand)

        self.database.commit()

        ttraceset   = ldb.records.TTraceSet(
            experimentId    = db_experiment.id,
            targetId        = db_target.id,
            fixedBlobId     = ts_fixed.id,
            randomBlobId    = ts_rand.id,
            parameters      = param_str
        )

        self.database.insertTTraceSet(ttraceset)

        self.database.popAutoCommit()

        try:
            self.database.commit()
        except Exception as e:
            log.error("Failed to add traceset into the database.")
            log.error(str(e))
            return 1
        
        log.info("Inserted TTraceSet to database: id=%d" % ttraceset.id)

        return 0
