
# 1. Memory Bus Registers

Memory busses and interconnects are expensive to drive signals over, or
to have toggle unnecessarily.
This is because:
- The traces often travel long distances across the chip (compared to an
  ALU datapath for example).
- Many different sub-systems are connected to the same bus.
- It may take multiple clock cycles to send and recieve a memory transaction
  due to stalls or interconnect latency.

They behavior of memory busses is rarely documented for the programmer.
While great care can be taken through measurement and even informed
assumptions about CPU register (overwrite) behaviour, memory hierarchy
registers are often much more obscured.

Further, they are often time-multipliexed between different resources.
This can even occur in single-agent systems where a micro-controller tries
to access data and instructions from the same memory. This multiplexing
can mean values are left in registers which are not related to the
currently running program, and their overwrite can cause leakage a long
time after the original program was finished with it.

**Questions:**

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
interconnect, allowing it to talk to memory and peripherals.
The data lines of this bus are usually as wide as the register word width
of the CPU: A 32-bit CPU will have a 32-bit data bus.

CPUs often operate on values which are smaller than the word width of
the register.
This is commonly seen in block ciphers.
When loading and storing sub-word values, what happens on the rest of
the bus is not known to the programmer.
Past work suggests that sometimes, more information than
was requested is driven onto the bus, which may cause more or
different leakage than was expected.

One may also be able to reason about bus behavior by analysing bus
standards such as AXI, AMBA and Wishbone.
These standards define the physical signals used to communicate, as well
as how data is layed out on them.

See: [ld_byte/README.md](ld_byte/README.md)

**Questions:**

1. For each popular micro-controller bus standard, survey their
   behavior with respect to sub-word width accesses.

   - Is their handling of sub-word acceses fully specified?

   - Can reasonable assumptions be made about their implementation be made in
     the absence of a total specification?

2. Can we reverese engineer how a bus handles sub-word data accesses?

   - Theoretically it should be possible to demonstrate this using
     well chosen data being loaded and stored, and creating an expectation
     for how much adjoining data is also transfered but discarded.

3. Can we do this for multiple CPUs?
    
   - RISC style architecturs typically all have the same collection
     of byte/halfword/word load and store instructions.

4. Can we do this for multiple implementations of the same CPU?

   - Do the results differ?

5. Can we get a better leakage estimation by taking this into account?

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
  - If I expect entire word to be loaded, use weight of word.
  - If I expect only asked for data to be loaded, use weight of sub-word.
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
