
# Pipeline Leakage Study

*A collection of tools and experiments for investigating side-channel
leakage due to pipelining and other implementation decisions in CPUs.*

---

# Ideas & Questions

*A set of ideas for experiments and the questions they should answer.*

## 1. Memory Bus Registers

Memory busses and interconnects are expensive to drive signals over, or
to have toggle unnecessarily.

Their value will be driven by registers, which change in value
only when needed.

Questions:
1. Can we identify the number of register stages loaded data must travel
  through in a system by observing power based side channels?
  - Can we do this for multiple CPUs?
  - Can we do this for the same CPU on multiple systems?
2. Can we use this information to obtain a better leakage estimate?
3. Can we use this information to better minimise leakage?

## 2. Memory Bus Widths

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

## 3. Pipeline Registers

Most CPUs are implemented using pipelines. The presence of a pipeline
implies several things about the underlying architecture:
- Instruction execution is spread across time.
- Data-dependent leakage is spread over time.
  - The same value may leak in different places in the trace.
- To prevent RAW hazards, CPUs must either stall, or  *forward* data from
  later stages to earlier stages.

Questions:
1. Can we identify the length of a pipeline just from side-channel
  information?
2. Can we show which information appears in which stage of the pipeline?
  - Expect immediates to appear early.
  - Register read data next.
  - Result data should appear last.
3. Can we identify forwarding paths by looking at side-channel information?
  - Does activation of these paths increase leakage?
4. Can we use this information to inform instruction scheduling choices to
   minimise leakage?

## 4. Latent Execution Leakage

This is Dan's "spectre for side-channels" idea.

In an `N` length pipeline (without considering branch prediction for now)
control flow changes typically occur in the very last stage.
- This means that there are upto `N-1` instructions in varying stages of
  completion in preceeding stages.

Questions:
1. Can we identify the presence of these instructions using side-channel
   leakage information?
  - Can we exploit whatever leakage they produce?
  - If we cannot observe this leakage, why might that be?
2. Does such leakage contribute to "ghost" leakage observed in the past,
   where certain values continue to leak long after they are "finished"
   with.

---

# Experiments

*A concrete list of experiments which should shed light on the questions
above.*

TBD.

---

# Target Platforms

*A list of candidate devices and platforms on which to perform these
experiments*

**FPGA + Xilinx Microblaze:**
- Use the Sasebo FPGA platform
- Use Xilinx own Microblaze configurable CPU.
- The CPU has a *configurable* pipeline depth, and it's micro-architecture
  is mostly undocumented beyond that.
- We can configure the surrounding AXI interconnect as well to add register
  stages to the memory busess.

**SCALE Boards:**

- ARM M0/3/4 core support.
- Possibly RISC-V support?
- Represent real world systems.
- Mostly un-documented internals of the CPUs themselves, some clues
  about pipeline information.

**SiFive HiFive board:**

- Rocket chip based microcontroller
- Would need to mod it to get a scope onto the power trace.

**FPGA + PicoRV32:**

- A multi-cycle micro-architecture CPU.
- Interesting to run the same benchmarks on a multi-cycle machine and
  see what the differences are.

---
