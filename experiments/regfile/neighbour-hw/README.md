/*!

@defgroup experiments-regfile-neighbour-hw
@ingroup  experiments-regfile
@brief Do we see hamming weight leakage from registers we never access?

## Purpose:

Reproduce the "neighbour leakage effect" from the "Mind the gap" paper.

## Method:

TBD

## Expectations:

TBD

## Running the experiment

To run all stages of the experiment for a particular target device:

```
make -B USB_PORT=[PORT] UAS_TARGET=[TARGET] flow-regfile-neighbour-hw
```

Where:
- `[PORT]` Is the UART/Serial port to communicate with it over.
- `[TARGET]` Is one of the target names listed in @ref targets

This will run all of the build, program, capture and analyse steps for
the experiment on the specified target.

The individual steps of the experiment are run with the following commands:

- Build: `make build_[TARGET]_regfile-neighbour-hw`
- Program: `make program_[TARGET]_regfile-neighbour-hw`
- Capture: `make capture_[TARGET]_regfile-neighbour-hw USB_PORT=[PORT]`
- Analyse: `make analyse_[TARGET]_regfile-neighbour-hw`

*/
