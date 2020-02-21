
import os
import logging as log

import ldb
import scass

class CaptureOperands(object):
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

    def createWorkDirSub(self, sub):
        path = os.path.join(self.original_work_dir,sub)

        if(not os.path.isdir(path)):
            os.mkdir(path)
            log.info("Created workdir subdirectory: '%s'" % path)

        return path

    def createTTestCaptureClass(self, variable_values = {}):
        """
        Boilerplate code for creating a ttest capture object and
        setting it up with the right input variable values.
        """
        
        tt_traces = os.path.join(self.work_dir,"traces.npy.gz")
        tt_fixed  = os.path.join(self.work_dir,"fixed.npy.gz")

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

    def dbInsertTTestTraceSet(self, 
                              ttest,
                              traceset_name,
                              experiment_catagory,
                              experiment_name,
                              overwrite = True):
        """
        Adds a ttest trace set record into the database. Deletes any
        existing databases which already exist with the same matching
        credentials.
        """
        ac                       = self.database.autocommit
        self.database.autocommit = False

        db_experiment   = self.dbGetOrInsertExperiment(
            experiment_catagory, experiment_name
        )

        db_target       = self.database.getTargetByName(self.target_name)
        
        if(db_target == None):
            log.error("No such target in database: '%s'" % (
                self.target_name
            ))
            return 1

        param_dict      = {}

        for var in ttest.tgt_vars:
            if(var.is_input and not var.is_ttest_variable and not var.is_randomisable):
                param_dict[var.name] = var.fixed_value

        param_str       = str(param_dict).rstrip("}").lstrip("{")

        traceset = ldb.records.TraceSet(
            name            = traceset_name,
            set_type        = "ttest",
            filepath_fixed  = ttest.trs_fb_file,
            filepath_traces = ttest.trs_file,
            experimentId    = db_experiment.id,
            targetId        = db_target.id,
            trace_length    = self.trigger_window_size,
            parameters      = param_str
        )
            
        pre_existing = self.database.getTraceSetByTracesFilepath(
            traceset.filepath_traces
        )

        if(overwrite and pre_existing != None):
            stattraces = self.database.countStatisticTracesForTraceSet(
                pre_existing.id
            )

            log.warn("Removing pre-existing traceset with same file path and %d associated statistic traces." % stattraces)

            self.database.removeTraceSet(pre_existing.id)
            self.database.commit()
            
            stattraces = self.database.countStatisticTracesForTraceSet(
                pre_existing.id
            )
            assert(stattraces == 0),"Failed to remove downstream statistic traces"

        self.database.insertTraceSet(traceset)

        self.database.autocommit = ac

        try:
            self.database.commit()
        except Exception as e:
            log.error("Failed to add traceset '%s' into the database." % (
                traceset_name))
            log.error(str(e))
            return 1
        
        log.info("Insert traceset to database: id=%d" % traceset.id)

        return 0
