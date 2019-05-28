
# Bus Width Experiment.

## Purpose

To work out how wide the data bus of a SoC is.

**Method:**
- Start with an `N` byte array, which is aligned to the largest bus width
  which we think is plausible.
  - In this case, the array is aligned to a 4-byte boundary.
  - The array is `8` bytes long.
- Initially, run a T-test such that in each trace:
  - We load the 0th byte of the array using a *load byte* instruction.
  - We randomise the entire contents of the `N` byte array.
- Next for `i=0..N`:
  - Run a T-test such that the first `i` bytes of the input array are
    kept constant, while others are randomised per trace.

**Expectations:**
- For an `X` byte wide bus (where `X<N`), we should continue to see leakage
  for all `i=0..X`.
- For all `i=X+1..N`, we should see no leakage.
- This would show that when we ostensibly load a *byte*, we in fact recieve
  an entire word, only one byte of which is kept and written to an
  architectural register.

## Running the experiment

**For a specific target and fixed byte width:**

```sh
make -B USB_PORT=<port> ttest_<target>_memory-bus-width TTEST_CAPTURE=./experiments/memory-bus/bus-width/ttest.py TTEST_FLAGS="--fixed-byte-len N"
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
./experiments/memory-bus/bus-width/scale-ttest_all.sh <target> <serial port>
```

Where:
- `<target>` is the target platform.
- `<serial port>` is the serial port to communicate with the target over.

**For all FPGA targets for all fixed byte widths:**

```sh
./experiments/memory-bus/bus-width/sakurax-ttest_all.sh <serial port>
```
Where:
- `<serial port>` is the serial port to communicate with the target over.

