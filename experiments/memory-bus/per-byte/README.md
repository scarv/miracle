
# Per-byte Experiment

## Purpose

To confirm that for a given bus width `B`, loading any byte from a
`B`-byte aligned word, will also fetch the bytes within that `B-aligned`
word, as opposed to the next `B-1` bytes.

**Method:**
- Start with an `N` byte array, which is aligned to a `B`-byte boundary
  - In this case, the array is aligned to a 4-byte boundary.
  - The array is `8` bytes long.
- Initially, run a T-test such that in each trace:
  - We randomise the entire contents of the `N` byte array.
  - The instruction sequence is a series of *load byte* instructions.
  - The first instruction loads the 0'th byte, the second instruction
    loads the 1'st byte, etc upto `B`.
- Next for `i=0..N`:
  - Run a T-test such that the first `i` bytes of the input array are
    kept constant, while others are randomised per trace.

**Expectations:**
If a load byte instruction tries to load a source byte at address `A`,
it may load one of:

1. Just the byte at `A`
2. The entire `B`-byte aligned word, which `A` resides in.
3. A `B`-byte word, the `0`'th byte of which is `A`.

- We can use the *memory/bus-width* experiment to reject case 1.
- If case 2 is true, we should *stop* seeing leakage when all bytes
  preceeding `A` are kept constant.
- If case 3 is true, then even if all bytes in the input array upto and
  including `A` are kept constant, we should still see data dependent 
  leakage due to the `B-1` other bytes being loaded.

## Running the experiment

**For a specific target and fixed byte width:**

```sh
make -B USB_PORT=<port> ttest_<target>_memory-per-byte TTEST_CAPTURE=./experiments/memory-bus/per-byte/ttest.py TTEST_FLAGS="--fixed-byte-len N"
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
./experiments/memory-bus/per-byte/scale-ttest_all.sh <target> <serial port>
```

Where:
- `<target>` is the target platform.
- `<serial port>` is the serial port to communicate with the target over.

**For all FPGA targets for all fixed byte widths:**

```sh
./experiments/memory-bus/per-byte/sakurax-ttest_all.sh <serial port>
```
Where:
- `<serial port>` is the serial port to communicate with the target over.

