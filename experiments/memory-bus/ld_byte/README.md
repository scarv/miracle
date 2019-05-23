
# Load Byte 0 Experiment.

## Purpose

To identify if loading a single byte of data produces leakage due to
also loading adjacent bytes within the selected word.

**Method:**
- The code kernel executed is a string of nops, followed by a
  load byte instruction, followed by a string of nops.
  - The nops act as a baseline to prevent function prelude/exitlude code
    from interfering.
  - The load byte instruction always loads data from the address in
    argument register 0, with an immediate offset of zero.
  - The base address points to the start of the input data array.
- The kernel is run such that the input data array always contains either:
  - a fixed value
  - A uniformly distributed random value, but where the 0'th byte in the
    array is the same as the 0'th byte of the fixed value.
- A TTest in then run, where one trace set is the fixed values, and the
  other is the random values with the fixed 0th byte.

**Expectations:**
- If *only* the requested byte is loaded, there should be no information
  leakage when running a TTest.
- If data as well as the requested byte is loaded, we should see information
  leakage, even though we only ever asked for the 0th byte.

## Running the experiment

**For a specific target and fixed byte width:**

```sh
make -B USB_PORT=<port> ttest_<target>_memory-ld_byte TTEST_CAPTURE=./experiments/memory-bus/ld_byte/ttest.py TTEST_FLAGS="--fixed-byte-len N"
rt
```

Note:
- The `TTEST_CAPTURE` variable sets the script used to administer the ttest.
  The default script will not work with this experiment, you *must* use
  the one shown in the example above.

Where:
-  `<target>` is the desired target platform to run on.
- `N` is the number of bytes in the "random" trace set to make identical
  to the fixed value.

**For a scale target for all fixed byte widths:**

```sh
./experiments/memory-bus/ld_byte/scale-ttest_all.sh <target> <serial port>
```

Where:
- `<target>` is the target platform.
- `<serial port>` is the serial port to communicate with the target over.

**For all FPGA targets for all fixed byte widths:**

```sh
./experiments/memory-bus/ld_byte/sakurax-ttest_all.sh <serial port>
```
Where:
- `<serial port>` is the serial port to communicate with the target over.

