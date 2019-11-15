
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

**Specific:**

1. To create a set of (reasonably) portable micro-benchmarks which:
   
   - Stimulate the supposed leakage mechanisms and provide evidence for
     hypotheses about their behaviour.

   - Can be used to profile a SoC. Either with a view to attacking it, or
     minimising the leakage from it.

2. (dis)prove the presence of memory-bus sub-word leakage for specific
   SoCs / systems.

3. (dis)prove the presence of latent execution leakage for specific
   SoCs / systems.

4. Catalogue the effects of assembly level translation of programs into
   machine code, and if/how assumptions about `NOP` behavior hold
   under power side-channel analysis.

5. Investigate how logic-gating affects power side-channel leakage.


