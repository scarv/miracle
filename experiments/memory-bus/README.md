
# 1. Memory Bus Registers

Memory busses and interconnects are expensive to drive signals over, or
to have toggle unnecessarily.

Their value will be driven by registers, which change in value
only when needed.

Questions:
1. Can we identify the number of register stages loaded data must travel
  through in a system by observing power based side channels?
   - Can we do this for multiple CPUs?
   - Can we do this for the same CPU on multiple systems?
2. Can we work out if data loaded/stored some time ago remains in a register,
   which might get overwritten on the next load?
3. Can we use this information to obtain a better leakage estimate?
4. Can we use this information to better minimise leakage?


# 2. Memory Bus Widths

Typical micro-controller based SoCs will have some sort of bus
interconnect, allowing the uC to talk to memory and peripherals.

The data lines of this bus are usually as wide as the register word width
of the CPU. A 32-bit CPU will have a 32-bit data bus.

When loading and storing sub-word values, parts of the bus are not
used.

However, past work suggests that sometimes, more information than
was requested is driven onto the bus, which may cause more or
different leakage than was expected.

Questions:
1. Can we reverese engineer how a bus handles sub-word data accesses?
2. Can we do this for multiple CPUs?
3. Can we do this for multiple implementations of the same CPU?
   - Do the results differ?
4. Can we get a better leakage estimation by taking this into account?
   - Is this leakage exploitable?
   - Can we use this information to better minimise leakage?

---

# Experiments

## Memory hierarchy registers

How can we identify register stages in the memory hierarchy?

**Loads:**

Setup:
- Zero a memory region, say 64 bytes worth.
- In the middle of that region, put a random conspicuous value(s) to be
  loaded.
- Create an instruction sequence of `N` nops, followed by a load
  byte/half/word, followed by `N` nops.
- The load should ask for the conspicuous value.

Running:
- Do a t-test on the code sequence.
- Run the kernel in a loop, triggering from first to last nop.
- Use an extremely high sample rate to capture the load data moving
  all the way from the memory into the core architectural registers.

Expectation:
- Expect hamming weight peaks at each register stage.
- Use peaks to identify register stages in the memory hierarchy.

Variants:
- Use two directly adjacent loads of two different (random) values and use
  hamming distance to more accurately identify register stages.

Considerations:
- Prior to executing the loop kernel, load zeros from memory into the core so
  we are sure any possible registers are "empty".
- If caches are present, they must be flushed prior to each run of the
  kernel.

**Stores:**

- As with loads, but this time, storing a random value from registers
  into memory.
- Taking care to store zeros to the memory destination locations to stop
  possible pollution between runs.

## Memory bus sub-word handling

How can we identify how different data-widths are transported from memory
into the CPU and back?

**Loads:**

Setup:
- Zero a memory region.
- Identify a naturally aligned word in the middle of said region, and fill
  it with known random data.
- Create an instruction sequence of `N` nops, followed by a word/half/byte
  load to the zeroth byte of the identified word, followed by `N` nops.

Running:
- Run a t-test on the code sequence, modifying the identified zeroth byte
  value each time.

Analysis:
- For all combinations of:
  - load word/half/byte
  - data word value
  - expected loaded data
- Create a hamming weight estimate, and perform simple CPA on each trace.
- Highly corrolated estimates indicate a correct combination of possible
  transported data.
- This should let us answer if, when we load a byte, we also load the
  naturally aligned word that byte belongs too, before discarding the 
  un-needed data.

Variants:
- For byte loads, try repeating the experiment for each of the four
  bytes in a naturally aligned word.
- For halfword loads, try repeating the experiment for the two
  halfwords in a naturally aligned word.

**Stores:**

When we store data not naturally aligned to the width of the data bus,
how is that handled?

TODO:

---

[Back Home](../../README.md)
