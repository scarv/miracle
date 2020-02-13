
# Leakage Database

*Notes on the backend database and interface used to store leakage
 experiment results*

---

## Requirements

The database must be able to:

- Store information on each device
- Store information on each experiment
- Store information on each *statistic* trace captured as part of an
  experiment.
- Store information on artifacts used to capture traces.

- Update information on a trace capture.
- Update information on an experiment setup per device.

- Delete any trace capture.

- Subset information out of the database for distribution.

## Interfaces

- Separate interface to information from DB backend - could use file system
  or [No]SQL etc.

- Python API usable by command line tool *and* web app.

  - Command line tool used by make flow to insert data into the
    database post analysis.

  - Web app mostly for comparison / subsetting etc.

## Tables

- Devices
  - Blob store of info?

- Experiments
  - ID / Name / Description?

- Experiment Artifacts
  - Device
  - Disassembly
  - Elf File

- Trace Captures
  - Date/time
  - Experiment
  - Device
  - Statistic Type
  - Frequency of target device
  - Scope information: frequency/resolution

