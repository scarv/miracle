
# Bus Width - Load Bytes

*What can we discover about the internal data memory bus is based on
 power side-channel information leakage?*

---

## Background

CPUs with a 32-bit internal datapath or word width will often use
a 32-bit wide memory bus.

Some bus standards work in terms of word widths only, and for reads
in particular, cannot specify a sub-word memory access.
Write accesses use per-byte strobe lines.

## Purpose:

Generally, this experiment seeks to answer the question:
"When loading a byte from memory, is *only* that byte operated on by
the memory hierarchy and the SoC, or do we also get other surrounding
bytes?"

Specific questions arrising from this:

- Given that other bytes are also operated on, which bytes are these?

- Do the loaded bytes correspond to a particular memory word alignment?

## Method:

When capturing the data:

- Define 2 `N` byte arrays:

    - The `zeros` array, which always contains zeros.

    - The `din` array, which contains all zeros except from some byte index
      `I`, which acts as the fixed/random variable in a TTest.

- The variable `O`, is an offset into the `din` and `zeros` arrays.

- For each value of `O` in some range, execute the following sequence of
  operations.

    - Load the `O`'th byte from the `zeros` array. This is to *flush* the
      memory load data path from any previous accesses so that they don't
      polute the experimnet.

    - Load the `O`'th byte from the `din` array. This is the critical
      operation we observe in the TTest.

    - Load the `O`'th byte from the `zeros` array again to flush the path.

    - Each load byte instruction is inter-spersed with `NOP` instructions so
      there is no chance of leakage from one instruction being missattributed.

- Repeat the experiment, strobing through different values of `O` and `I`.

When interpreting the results:

- If `O` == `I`, we should expect to see first order leakage in a
  standard non-specific TTest.

- If `O` != `I` then...

    - If we see leakage, this means that despite asking for a constantly
      zero'd byte, we still see the `I`'th byte being manipulated by the
      SoC.

    - If we do not see leakage, then the `I`'th byte has not been manipulated.

## Expectations:

We expect to see either:

- No leakage when loading bytes other than the one at position `I`.

- Leakage when loading all bytes in the range `I-(I%4)` to `(I-(I%4))+3).

  - This would imply that whenever a byte is loaded, the entire word in
    which it resides is in fact manipulated and presented to the CPU,
    which then throws away the extra bytes.

## Running

```
make UAS_TARGET=<tgt> flow-memory-bus-bus-width-ld-bytes
```

