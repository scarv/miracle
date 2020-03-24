
# Make Flow

*How to use the Make flow to orchestrate building, programming and
running experiments on devices.*

---

## Overview

- Before using the make flow, you *must* source the workspace
  setup script:

  ```sh
  source bin/conf.sh
  ```

  This sets up the environment variables for the project.

- Make sure that the nessesary toolchain environment variables are
  also setup *before* sourcing the `bin/conf.sh` script.


- The make flow divides everything into four conceptual steps:

  - `build` - Build one or more experiment executable files for a
    given target device.

  - `program` - Given a built experiment executable for a target device,
    program the target device with that exectuable.

  - `capture` - Capture one or more sets of data from a programmed device,
    and store the recorded traces in the results database.

  - `analyse` - Given recorded traces in the database, run some
    general and experiment specific analyses on those traces.
    Analysis results are placed back in the database.


## File Structure

The following are useful files relating to the make flow:

- `$REPO_HOME/Makefile` - The top level makefile, used to orchestrate the
  rest of the flow.

- `$REPO_HOME/common.mk` - Common targets and variables used across the make
  flow.

- `$REPO_HOME/build.mk` - Top level makefile used to build experiment
  executables for targets. Includes target specific makefiles.

  - `$REPO_HOME/target/[target]/build/build.mk` - Target specific
    makefiles used to setup flags and toolchains for building experiments.

- `$REPO_HOME/program.mk` - A skeleton makefile which just includes
  target specific makefiles to program devices with experiments.

  - `$REPO_HOME/target/[target]/program/program.mk` - Target specific
    makefile for programming devices with experiments.


## Building

- Each target device defines some common Make code for how to build
  an experiment for it.

  - See any of the `target/<TARGET>/build/build.mk` files for an example.

  - These are included by the top level `Makefile.build`, which is
    responsible for all experiment compilation jobs.

  - `Makefile.build` can be invoked directly, but it is easier to let
    the normal `Makefile` orchestrate that for us, as is shown below.

- We can build any experiment `E` for target `T` with the following
  command:

  ```sh
  make build_[T]_[E]
  ```

  Substituting `T` and `E` for proper values.

- Some examples:

  ```sh
  make build_cw308_stm32f071_speculation-unpredictable-0
  make build_cw308_stm32f4_countermeasures-rosita-ld-ld-0
  make build_sakurax_mb5_countermeasures-rosita-ld-ld-1
  make build_scale_lpc1313fbd48_countermeasures-rosita-ld-ld-2
  ```

- Each target `T` should be one of the directory names
  found under `$REPO_HOME/target/`

- Each experiment name `E` is a combination of two directory names
  under `experiments/`. the major *catagory* directory and one subfolder.

  For example: `memory-bus/bus-width-ld-bytes` is re-written with the
  `/` replaced with a `-`: `memory-bus-bus-width-ld-bytes`.


## Programming

- Every target includes its own Makefile responsible for programming the
  target with an experiment executable.

  - This is stored in `target/<target name>/program/program.mk`

  - The `target/<target name>/program` directory also contains any
    additional files needed to program the target.

- The top level `Makefile.program` simply includes the target-specific
  makefile.

- Every `program.mk` file must provide a `program` target, which can
  list input executable files as dependencies.

  - The input executable files can be discovered using macros defined
    in the top level `common.mk` file.

- The end result of running the `program` target is that the target device
  is left in a state where it is running the desired experiment code
  and is ready for communication with the analysis flow.

- The `program` target is sensitive to several command line arguments:

  - `UAS_EXPERIMENT=<experiment name>` - the name of the experiment to
    program into the target device.

  - `PROGRAM_WITH_OPENOCD=0/1` - Whether to use `openocd` to program the
    target device, or whether to use a specialist programmer.
    Some targets can do either, some can only do one.

- The easiest way to program a target is using the top level makefile:

  ```sh
  make program_[T]_[E] PROGRAM_WITH_OPENOCD=0/1
  ```

  Where `[T]` is the taget name and `[E]` is the experiment name.

  For example:

  ```sh
  make program_cw308_stm32f071_speculation-unpredictable-0
  make program_cw308_stm32f4_countermeasures-rosita-ld-ld-0
  make program_sakurax_mb5_countermeasures-rosita-ld-ld-1
  make program_scale_lpc1313fbd48_countermeasures-rosita-ld-ld-2
  ```

- The program targets expect the relevant hardware and programmers to
  be available when run.

  - For the ARM targets, a Segger JLink probe has been used, along
    with OpenOCD.

  - For the FPGA targets, a Xilinx programmer and Vivado are used.


## Capture

- The capture flow is initially started by the top level
  `Makefile` using one of the `capture_[T]_[E]` targets, where
  `[T]` is a target name and `[E]` is an experiment.

  - For example:

    ```sh
    make capture_cw308_stm32f071_speculation-unpredictable-0
    make capture_cw308_stm32f4_countermeasures-rosita-ld-ld-0
    make capture_sakurax_mb5_countermeasures-rosita-ld-ld-1
    make capture_scale_lpc1313fbd48_countermeasures-rosita-ld-ld-2
    ```
  
  - This starts a Python3 script (`tools/flow/capture.py`)
    which orchestrates experiment and device specific
    capture requrements.

- The top level make target is sensitive to several command line
  arguments:

  - `USB_PORT` - The serial port with which to connect to the device.

  - `USB_BAUD` - The connection speed of the serial port. This is also
    specified by default in the per-target configuraton files
    found in `target/[NAME]/[NAME].cfg`.

  - `TTEST_NUM_TRACES` - The number of traces to collect per TTest
    performed by the experiment.

  - Other arguments can be found by investigating the `add_tgt_capture`
    macro in the top level `Makefile`.

- Captured experiment data is stored in the database file under
  `work/database.sqlite`.

- **Note:** The build, program and capture steps can be run automatically
  in sequence using the `flow_*` targets:
    
  ```sh
  make UAS_TARGET=[target name] flow_speculation-unpredictable-0
  make UAS_TARGET=[target name] flow_countermeasures-rosita-ld-ld-0
  ```

  Where `[target name]` referrs to one of the target platforms.

  The same command line arguments detailed above can also be passed
  to the flow target.


## Analysis

- The analysis flow is responsible for taking experiment data in the
  database, running general and per-experiment analyses on it, and
  putting the results back in the database.


- We can run analysis for a single target and experiment combination:
  
  ```sh
  make analyse_[T]_[E] 
  ```
  
  Where `[T]` is a target name and `[E]` is an experiment.

  For example
  ```sh
  make analyse_cw308_stm32f071_speculation-unpredictable-0
  make analyse_cw308_stm32f4_countermeasures-rosita-ld-ld-0
  make analyse_sakurax_mb5_countermeasures-rosita-ld-ld-1
  make analyse_scale_lpc1313fbd48_countermeasures-rosita-ld-ld-2
  ```

- We can also run analysis on all experiment data for a given target
  device:

  ```sh
  make UAS_TARGET=[target name] analyse-all-experiments-for-target
  ```

  For example:

  ```sh
  make UAS_TARGET=cw308_stm32f071  analyse-all-experiments-for-target
  make UAS_TARGET=cw308_stm32f4    analyse-all-experiments-for-target
  make UAS_TARGET=nxp_lpc1115fbd48 analyse-all-experiments-for-target

  ```

- To perform the analysis, the top level `Makefile` runs a Python3
  script: `tools/flow/analyse.py`.

  This script is responsible for connecting to the database, getting
  data out, passing it to the experiment specific analysis code and
  putting the results back.

- Running:

  ```sh
  $REPO_HOME/tools/flow/analyse.py --help
  ```

  Will show how the analysis script can be used standalone.

