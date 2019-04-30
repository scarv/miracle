
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

