
# Project Background

---

## Overview

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


## Motivation and Background

Why were we doing this in the first place?

- Cryptographic engineering is *hard*.
- Side-channel resistant software is *extremely hard*.
  - There is a lot of literature on *algorithms* which, if implemented
    correctly, we are reasonably confident will behave robustly under leakage
    analysis.
  - We have a weak notion of "correctness" with respect to leakage
    resilience.
  - Attacks and detection techniques are improving all the time. Their
    results or the exactness/strength of their claims are often misstated or
    misunderstood.
  - Theoretically provably secure algorithms, once implemented, does not
    always stay secure.
  - It is rarely obvious exactly where leakage is coming from or why. There
    are many device specific pitfalls which one can encounter when writing
    leakage resistant code.
- There is lots of literature on abstract masking algorithms, and on
  implementation effects which give rise to leakage. However, these two
  bodies of literature rarely seem to interact.
- There is a need for *practical guidance* and information for engineers:
  - How to approach writing leakage resistant code for a given device.
  - How to design a new device with leakage resilience in mind.
- Different devices are often hard or impossible to compare based on their
  leakage characteristics.
  - E.g: the ARM M0 core is one of the most studied devices in the world from
    a leakage perspective. But finding comparable data-sets or lists of
    characteristics / implementation "*gottcha's*" is almost impossible.

## Contributions

Currently, the paper is setup as an incremental improvement on the status
quo, because the main contribution is in terms of the new effects we have
discovered.

Arguably, a bigger contribution is being able to organise each of these new
effects, and devise experiments to test for them quantitatively. Having clear
examples of new/interesting/existing effects then act as a useful
contribution in their own right, as well as acting as a proof of concept /
usefulness for the tooling and methodology.

It's reasonable to assert that there are potentially hundreds/thousands of
different combinations of device, micro-architectural leakage source and
methods of exploitation. The value of finding any given one of these is hence
small, given the total problem space (this sort of follows from existing
literature, where many papers appear each detailing a small effect). The real
value then comes from making it easy to explore the problem space, and
organise the results of that exploration.

Qualitative:

- Raise awareness of implementation difficulties across the literature, and
  bridge the gap between more "theoretical" leakage papers v.s. empirical
  studies of leakage effects.

- Understand how the same *code* can leak differently across different
  devices.

- Understand how the same *action* (syntactically different but semantically
  identical code) can leak differently across different devices.

- Understand what the most important questions are about a device from the
  perspective of it's behavior under leakage analysis.

- Enable a 3rd party to contribute information on a device, or pose a new /
  relevant experiment.

Tooling:

- Create a set of micro-benchmarks which probe *specific* pieces of
  functionality about a range of devices.

  - Ideally, each benchmark yields either a yes/no answer to a question of
    the form "Does device X exhibit leakage when executing this particular
    code-idiom"

  - Care should be taken to avoid questions which tempt comparisons of the
    "Device X leaks *more/less* than device Y". The current methods of
    leakage in the literature do not support such comparisons.

Methodology:

- A tool flow that is totally separable from the devices and experiments.

- Create a standardised flow for running said benchmarks on different devices
  and collating their results *in an actionable way*.

- It should be *trivial* for individuals / organisations to add both new
  devices and new benchmarks.

  - Present results such that the community can add to them over time.

Systematization of Knowledge:

- Given a set of benchmarks and a standardised flow for executing them,
  create a database of as many different devices and their analysis results
  as possible.

- Engineers/Researchers can then query the database:

  - For a given benchmark, how do all devices behave under it?

  - For a given device, what key leakage phenomena should I be aware of when
    writing leakage resilient code for it?

  - Does this device behave in ways that transparently undermine my proof of
    security?

  - Give some unexpected leakage in my implementation, which known effects in
    this device might be the cause?

  - How can / is this source of leakage be exploited? Do I as an engineer
    need to worry about it?

  - Which parts of the academic literature are relevant to this device or
    effect?

## Complimentary Work

There are obvious tie-ins to this as a project with the SCA3S.

- SCA3S will already act as a way of easily running simple (and more complex)
  leakage analysis jobs.

- It will certainly be able to handle the kind of "yes/no" feature questions
  which the envisaged benchmarks aim to answer.

- Having the sort of "device leakage profile" which the flow aims to provide
  for each device available through SCA3S seems to inherently add value to
  SCA3S as a platform.

- If an end goal of SCA3S is to let people run their own FPGA soft-cores
  through it, letting them do a "push-button" leakage phenomenon profile of
  their device seems useful.

## Conclusions

- Trying to find more and more interesting / esoteric sources of leakage from
  micro-architectures is useful in and of itself, but as an approach to
  research potentially misses the wood for the trees.

- We already have a number of useful / interesting / novel effects of our own
  to present, plus the past body of literature on the subject.

- What, as a community, is needed, is a way to systematically share and build
  on that knowledge.

- As a team in Bristol, we're good at automation.

  - This is somewhat forced on us due to the small size (in people) of the
    project.

  - By properly building out our tool flow this way (as with other projects),
    life will be made much easier in the future.

- While this pseudo-proposal stops just short of world domination and solving
  `p/=np`, by breaking the problem into tooling, experiments and data
  aggregation, we stand a reasonably good chance of pulling it off because
  we're building on tools we already have.

  - Once the tool flow is built in a robust way, adding new experiments and
    devices then becomes trivial.

  - It also helps as a way of creating concrete examples of effects alluded
    too in the literature.


## Paper Story

These are some notes on how to tell the story for the paper.

**Introduction:**

- Masking and (to a lesser extent) threshold implementations can be
  undermined by hardware which does not uphold the assumptions that
  the schemes rely on.

  - This is stated several times in the literature.

- There are a set of *folklore* effects from a small set of
  papers which detail how different micro-architectures can undermine
  different assumptions, and how to deal with them.

  - The papers usually only detail one or two effects for a single CPU
    and architecture.

  - Despite being noticed in the literature, there is little comparison
    between different CPUs / architectures.

- There are several use cases for this information:

  - When building a leakage resistant CPU, these effects must be documented
    in order to write software which uses the CPU to best effect.
  
  - When designing a countermeasure, will it be feasible to implement
    in the presence of these effects? How many of these effects can it
    tolerate and how can they be mitigated?

  - When writing leakage resistant code on a given CPU, an engineer
    or researcher needs to know about these effects so that their
    implementation is sound.

  - Automating leakage resistant code generation is impossible without
    knowing about these effects.

  - When attacking an implementation and device, knowledge of these effects
    can give the attacker additional information.

- Analog leakage resistant code is *not portable* between SoCs, let alone
  CPUs.

- The problem space of possible micro-architectural leakage effects is
  enormous. Any single effect is therefore important to a single
  implementation vulnerable to it, but less important to the field as a
  whole. Therefore, the valuable contribution is a database of
  effects which can be added too and extended over time.

**Key contributions:**

- Reproduce and disambiguate the *folklore* effects from across the literature
  across a wide range of devices and CPU architectures.

  - The code to stimulate these effects will be open-source and available
    for scrutiny.

- Document previously un-described effects around memory-bus widths
  and shallow pipeline speculation.

- Enable the creation of a *leakage datasheet* for devices, which detail
  the set of micro-architectural effects they exhibit which side-channel
  engineers / researchers need to be aware of.

**Previous Work:**

- Y. Le Corre, J. Großschädl, and D. Dinu. Micro-architectural power simulator
for leakage assessment of cryptographic software on ARM Cortex-M3 proces-
sors. In Constructive Side-Channel Analysis and Secure Design (COSADE),
LNCS 10815, pages 82–98. Springer-Verlag, 2018.

 - Hamming distance leakage in ALU operands.

- Papagiannopoulos, Kostas, and Nikita Veshchikov. "Mind the gap: towards secure 1st-order masking in software." International Workshop on Constructive Side-Channel Analysis and Secure Design. Springer, Cham, 2017.
 
 - Hamming distance leakage in instruction operands.

 - Memory remnant effect: RAMs remember last loaded value.

 - Neighbour effects.

- C. Cernazanu-Glavan, M. Marcu, A. Amaricai, S. Fedeac, M. Ghenea,
Z. Wang, A. Chattopadhyay, J. Weinstock, and R. Leupers. Direct FPGA-
based power profiling for a RISC processor. In IEEE International Instrumen-
tation and Measurement Technology Conference (I2MTC), pages 1578–1583,
2015

- W. Diehl, A. Abdulgadir, and J.-P. Kaps. Vulnerability analysis of a soft
core processor through fine-grain power profiling. Cryptology ePrint Archive,
Report 2019/742, 2019.

- H. Seuschek, F. De Santis, and O.M. Guillen. Side-channel leakage aware
instruction scheduling. In Cryptography and Security in Computing Systems
(CS2), pages 7–12, 2017.

- Sasdrich, Pascal, René Bock, and Amir Moradi. "Threshold implementation in software." International Workshop on Constructive Side-Channel Analysis and Secure Design. Springer, Cham, 2018.

- Si's bit rotation paper.

**Survey of effects:**

- For each documented effect from the literature, a small benchmark
  was created to test for it's presence/absence.

- Each benchmark was then run across `N=7` target devices.

  - `4` Different CPU architectures.

  - ASIC and Soft-core implementations present.

  - Different pipeline depths: `0`, `3`, `5` and `8`.


**New Micro-architectural Effects Case Studies:**

- Memory bus:

  - When loading a byte, we actually get a word.

  - When loading/storing consecutive words, we see a hamming distance leakage.

- Fine grain pipeline operand leakage

  - Hamming distance leakage of operand registers re-produced.

  - Isolation of different left/right operand registers.

  - ARM `mov` clears only the *left-hand* operand register.

  - ARM `nop` clears registers in the M0, but not the M3.

- Speculation / Branch Shadows.

  - Instruction execution in the shadow of a branch in short pipelines.


**Conclusions:**

- Re-state / emphasise that unless great care is taken, micro-architectures
  will undermine many countermeasure assumptions in non-obvious ways.

- A database of known effects will make mitigating these easier, and
  serve as a foundation for more automated tooling.

**Future Work:**

- Looking for more effects and accepting community contributions.

- Profiling more devices.

- "Profiling as a service" as part of SCA3S.
