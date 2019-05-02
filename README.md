
# Micro-architecture Leakage Study

*A collection of tools and experiments for investigating side-channel
leakage due to pipelining and other implementation decisions in CPUs.*

---

## Proposals

A set of ideas for experiments and the questions they should answer:
- [NOP Instructions](experiments/nop-instruction/README.md)
- [Memory Bus Effects](experiments/memory-bus/README.md)
- [Pipeline Effects](experiments/pipeline/README.md)
- [Latent Execution Leakage](experiments/latent-leakage/README.md)
- [Logic Gating](experiments/logic-gating/README.md)

Notes:
- [Target platforms](targets/README.md) to perform the experiments on:
- [Instruction Stream Generation](instr-stream-gen/README.md)

---

## Useful Links:

- [ARM Cortex M0 Technical reference](https://developer.arm.com/docs/ddi0432/c)
- [Xilinx UG984 Microblaze Processor Reference Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug984-vivado-microblaze-ref.pdf)
