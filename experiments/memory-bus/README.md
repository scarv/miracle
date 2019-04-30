
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

---

[Back Home](../../README.md)
