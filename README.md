
# Micro-architecture Leakage Study

*A collection of tools and experiments for investigating side-channel
leakage due to pipelining and other implementation decisions in CPUs.*

---

## Aims

**General:**

1. Investigate how the micro-architectural design of a CPU and SoC
   affect power side-channel leakage.

2. Investigate how the execution of instructions in a pipeline
   affects traditional assumptions about leakage, and to find better
   ways to model it.
   See [Pipeline Effects](experiments/pipeline/README.md).

**Specific:**

1. To create a set of (reasonably) portable micro-benchmarks which:
   
   - Stimulate the supposed leakage mechanisms and provide evidence for
     hypotheses about their behaviour.

   - Can be used to profile a SoC. Either with a view to attacking it, or
     minimising the leakage from it.

2. (dis)prove the presence of memory-bus sub-word leakage for specific
   SoCs / systems.
   See [Memory Bus Effects](experiments/memory-bus/README.md).

3. (dis)prove the presence of latent execution leakage for specific
   SoCs / systems.
   See [Latent Execution Leakage](experiments/latent-leakage/README.md).

4. Catalogue the effects of assembly level translation of programs into
   machine code, and if/how assumptions about `NOP` behavior hold
   under power side-channel analysis.
   See [Instruction translation](experiments/translation/README.md).

5. Investigate how logic-gating affects power side-channel leakage.
   See [Logic Gating](experiments/logic-gating/README.md)


## Proposals

A set of ideas for experiments and the questions they should answer:

- [Instruction translation](experiments/translation/README.md)
- [Memory Bus Effects](experiments/memory-bus/README.md)
- [Pipeline Effects](experiments/pipeline/README.md)
- [Latent Execution Leakage](experiments/latent-leakage/README.md)
- [Logic Gating](experiments/logic-gating/README.md)

**Notes:**

- [Target platforms](target/README.md) to perform the experiments on:
- [Instruction Stream Generation](tools/kernel-gen/README.md)
- [Relevent Papers](PAPERS.md)

---

## Useful Links:

- [ARM Cortex M0 Technical reference](https://static.docs.arm.com/ddi0432/c/DDI0432C_cortex_m0_r0p0_trm.pdf)
- [ARM Cortex M3 Technical reference](https://static.docs.arm.com/ddi0337/h/DDI0337H_cortex_m3_r2p0_trm.pdf)
- [ARM v6-M Architecture Reference Manual](https://static.docs.arm.com/ddi0419/e/DDI0419E_armv6m_arm.pdf)
- [ARM v7-M Architecture Reference Manual](https://static.docs.arm.com/ddi0403/ed/DDI0403E_d_armv7m_arm.pdf)
- [Xilinx UG984 Microblaze Processor Reference Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug984-vivado-microblaze-ref.pdf)
- [NXP lpc1114 Data Sheet](https://www.nxp.com/docs/en/data-sheet/LPC111X.pdf)
