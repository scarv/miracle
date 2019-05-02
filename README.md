
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
- [Relevent Papers](PAPERS.md)

---

## Useful Links:

- [ARM Cortex M0 Technical reference](https://static.docs.arm.com/ddi0432/c/DDI0432C_cortex_m0_r0p0_trm.pdf)
- [ARM Cortex M3 Technical reference](https://static.docs.arm.com/ddi0337/h/DDI0337H_cortex_m3_r2p0_trm.pdf)
- [ARM v6-M Architecture Reference Manual](https://static.docs.arm.com/ddi0419/e/DDI0419E_armv6m_arm.pdf)
- [ARM v7-M Architecture Reference Manual](https://static.docs.arm.com/ddi0403/ed/DDI0403E_d_armv7m_arm.pdf)
- [Xilinx UG984 Microblaze Processor Reference Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug984-vivado-microblaze-ref.pdf)
