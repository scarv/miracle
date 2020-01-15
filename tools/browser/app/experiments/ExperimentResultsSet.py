
import os
import logging as log

from .ExperimentTrace import ExperimentTrace

class ExperimentResultsSet:
    """
    Contains experiment results / artifacts information for a single
    combination of experiment and target device.
    """

    def __init__(self, experiment, target_name):
        """
        Create a new results set and discover any artifacts for it.
        """

        self._experiment = experiment
        self._target_name= target_name

        self._program_elf= None
        self._program_dis= None

        self._traces = {}

        self.__discoverArtifactsForTarget()


    def __discoverArtifactsForTarget(self):
        """
        Responsible for discovering all experiment results artifacts for a
        given target device.
        """
        tgt_results_dir = os.path.join(
            self.experiment.results_dir, self.target_name
        )

        program_elf = os.path.join(tgt_results_dir,"program.elf")
        program_dis = os.path.join(tgt_results_dir,"program.dis")

        if(os.path.isfile(program_elf)):
            self._program_elf = program_elf

        if(os.path.isfile(program_dis)):
            self._program_dis = program_dis

        traces_path = os.path.join(tgt_results_dir, "trace")

        if(os.path.isdir(traces_path)):
            for trace in os.listdir(traces_path):
                trace_path = os.path.join(traces_path,trace)
                if(os.path.isfile(trace_path) and trace.endswith("npy")):
                    etrace = ExperimentTrace(trace_path)
                    self._traces[etrace.name] = etrace
        else:
            log.error("No traces for %s/%s" % (
                self.experiment.name, self.target_name))

    def getTraceByName(self, tracename):
        """
        Returns a single ExperimentTrace object with the same name
        as `tracename` or None if no such trace exists in the results set.
        """
        return self._traces.get(tracename, None)

    def getTracesOfType(self, tracetype):
        """
        Return a list of all traces with a matching tracetype.
        """
        return [t for t in self.traces if t.tracetype == tracetype]

    @property
    def traceNames(self):
        return self._traces.keys()

    @property
    def traces(self):
        """
        Returns a List of traces in the results set.
        """
        return self._traces.values()
    
    @property
    def experiment(self):
        return self._experiment
    
    @property
    def target_name(self):
        return self._target_name

