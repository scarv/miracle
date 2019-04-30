
# Pipeline Leakage Study

*A collection of tools and experiments for investigating side-channel
leakage due to pipelining and other implementation decisions in CPUs.*

---

## Proposals

A set of ideas for experiments and the questions they should answer:
- [Memory Bus Effects](experiments/memory-bus/README.md)
- [Pipeline Effects](experiments/pipeline/README.md)
- [Latent Execution Leakage](experiments/latent-leakage/README.md)
- [Logic Gating](experiments/logic-gating/README.md)

[Target platforms](targets/README.md) to perform the experiments on:
- FPGA + Xilinx Microblaze
- FPGA + PicoRV32
- FPGA + SCARV in-house CPU Core
- SCALE M0/3/4 boards
- SCALE RISC-V board?
- SiFive HiFive Dev Board

---
