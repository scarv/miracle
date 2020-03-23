
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

TBD


## Capture

TBD


## Analysis

TBD


