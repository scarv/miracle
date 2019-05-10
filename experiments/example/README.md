
# Example Experiment

*A testbench for building the acquisition flows*

---

## Purpose

- To test trace acquisition functionality and host/target communication.

## Experiment Setup:

- None

## Experiment Run:

1. Sample two pseudo random values.
2. Set the trigger.
3. Run the experiment payload function.
   - Payload takes the two random values as a register arguments.
   - Run 10 architectural nop instructions.
   - Modular add the two operands into arg reg 2.
   - Run 10 architectural nop instructions.
   - XOR the two operands into arg reg 0.
   - Run 10 architectural nop instructions.
4. Clear the trigger.
