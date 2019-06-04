
# Bus Width Experiment.

- [Purpose](#Purpose)
- [Method](#Method)
- [Expectations](#Expectations)
- [Findings](#Findings)
- [Running The Experiment](#Running-the-experiment)

## Purpose:

- To work out how wide the data bus of a SoC is.
- To identify if, given a load byte instruction, multiple bytes are in
  fact loaded.

## Method:

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

## Expectations:
- For an `X` byte wide bus (where `X<N`), we should continue to see leakage
  for all `i=0..X`.
- For all `i=X+1..N`, we should see no leakage.
- This would show that when we ostensibly load a *byte*, we in fact recieve
  an entire word, only one byte of which is kept and written to an
  architectural register.

## Findings

### Overview:

- All targets are 32-bit platforms, and unsupprisingly, we found that the
  bus widths are 32-bits wide for all targets.

- We also found that if a word-aligned byte is fetched, other bytes are
  also transfered *in some way* between the memory and the CPU.
  - These extra bytes do not get committed to architectural state.
  - They are clearly visible in the T-test traces.

- For pre-existing systems, we now know that this is an effect which
  can be identified reasonably easily.

- For new systems being designed, we have some recommendations about how
  to augment a given bus standard, or bus standard implementation, to
  increase leakage resiliance.

### Discussion:

- Though the results are not supprising from a micro-architecture point of
  view, the result that more than the requested number of bytes are
  transfered has serious implications for side-channel analysis.

- The result was expected given knowledge of the bus architectures used
  in the target systems:

- The ARM microcontrollers all use AMBA AHB bus standards to communicate
  intra-chip. This standard allows for transfer sizes which are
  power-of-two numbers of bytes, *upto the width of the bus*.
  - This means that in a 32-bit bus, 1,2 or 4 bytes may be read or written
    by a bus master.
  - The width of the data transfer is controlled by the `HSIZE` signal,
    and the address (`HADDR`) does not need to be word aligned.
  - However, it appears that the tested CPU implementations *either* 
    a) always request an entire word, and throw away un-needed bytes or
    b) request only what they need, but the *memory device* always
       returns an entire word.
  - The net result is that more bytes than were requested are driven
    across the bus.

- The Xilinx FPGA softcore systems were set-up to use both ARM AXI 4.0
  busses[2], and Xilinx's own Local-Memory-Bus (LMB) standard [3].
  - AXI4 busses allow multiple transaction memory accesses. The number of
    bytes transfered per beat is specified by `ARSIZE`/`AWSIZE` for
    reads/writes respectivley. The number of beats in the burst is then
    controlled by the `ARLEN`/`AWLEN` signals.
  - The AXI4-Lite protocol simplifies this by forcing all bursts to
    have only 1 beat (`A*LEN = 1`) and all accesses are 
    *"the full width of the data bus"* (`A*SIZE = 4/8`).
    Busses may be *"32-bit or 64-bit"* wide.
  - Clearly, the AXI4-Lite protocol is inherently problematic from the
    perspective of fetching more bytes than are actually required by the
    core.
  - The full fat AXI4 protocol *may* also suffer from this problem, but
    that is *heavily* implementation dependent.

- The Xilinx LMB bus protocol is *"used as the LMB interconnect for Xilinx
  device embedded processor systems. The LMB is a fast, local bus for
  connecting the MicroBlaze™ processor instruction and data ports to
  high-speed peripherals, primarily on-chip block RAM (BRAM)."*[3,
  4 (chapter 3, p163)]
  - Particularly, it allows *single cycle* access to on-chip BRAM.
  - As with AXI4-Lite, it has no way of requesting less than 1-bus widths
    data from a slave device, meaning that even if a single byte is requested,
    and entire word of data is returned by the BRAM.

- It is clear that this extra, unexpected activity on data memory busses
  has undesirable implications for side-channel resiliance.

- We suggest that side-channel resilliant CPU and software design can only go
  so far in mitigating these vulnrabilities.

- There are some fundamental questions which instances of the examinied bus
  standards and target platforms must answer from a side channel perspective.
  - Clear documentation about sub-bus-word data transfer behaviour.
  - Clear per-perhiperhal documentation about how they fill redundant
    bytes of the data bus.
  - Clear documentation about which subset of possible bus behaviors the
    CPU engages in: Does is always request words and discard as needed?
    Does it always only request what is needs, but gets extra stuff anyway?

- These questions must be answered for *existing* systems. We also suggest
  the following guidelines for system *designers and implementers*, in the
  hope that future system interconnects can take pro-active steps to design
  with leakage resiliance in mind.
  - Almost all bus standards include some form of "write strobe" bits,
    which allow individual bytes within a 32-bit data word to be
    included or omitted from a memory write operation.
  - We suggest it makes sense to include corresponding "read strobe"
    lines, that can be used by a bus master to indicate exactly which
    bytes of the requested data it is interested in. Bus slaves can then
    return *only* the data requested.
  - When implementing (as opposed to specifying, as above) as bus standard,
    redundant bytes can be used to implement rudimentary countermeasures
    e.g. driving redundant bytes to the complement of used bytes, or
    even randomising their value.

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


## References

1. [ARM AMBA 5 AHB Protocol Specification AHB5, AHB-Lite](https://static.docs.arm.com/ihi0033/bb/IHI0033B_B_amba_5_ahb_protocol_spec.pdf)
2. [ARM AMBA AXI and ACE Protocol Specification AXI3, AXI4, AXI5, ACE and ACE5](https://static.docs.arm.com/ihi0022/fb/IHI0022F_b_amba_axi_protocol_spec.pdf)
3. [Xilinx Local Memory Bus (LMB) v3.0 LogiCORE IP Product Guide](https://www.xilinx.com/support/documentation/ip_documentation/lmb_v10/v3_0/pg113-lmb-v10.pdf)
4. [Xilinx UG984 Microblaze Processor Reference Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug984-vivado-microblaze-ref.pdf)
