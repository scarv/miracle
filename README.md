
# Micro-architecture Leakage Study

*A collection of tools and experiments for investigating side-channel
leakage due to pipelining and other implementation decisions in CPUs.*

---

## Overview:

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


## Motivation and Background for this work

Why were we doing this in the first place?

- Cryptographic engineering is *hard*.
- Side-channel resistant software is *extremely hard*.
  - There is a lot of literature on *algorithms* which, if implemented correctly, we are reasonably confident will behave robustly under leakage analysis.
  - We have a weak notion of "correctness" with respect to leakage resilience.
  - Attacks and detection techniques are improving all the time. Their results or the exactness/strength of their claims are often misstated or misunderstood.
  - Theoretically provably secure algorithms, once implemented, does not always stay secure.
  - It is rarely obvious exactly where leakage is coming from or why. There are many device specific pitfalls which one can encounter when writing leakage resistant code.
- There is lots of literature on abstract masking algorithms, and on implementation effects which give rise to leakage. However, these two bodies of literature rarely seem to interact.
- There is a need for *practical guidance* and information for engineers:
  - How to approach writing leakage resistant code for a given device.
  - How to design a new device with leakage resilience in mind.
- Different devices are often hard or impossible to compare based on their leakage characteristics.
  - E.g: the ARM M0 core is one of the most studied devices in the world from a leakage perspective. But finding comparable data-sets or lists of characteristics / implementation "*gottcha's*" is almost impossible.

## Contributions / Aims / End Goals

Currently, the paper is setup as an incremental improvement on the status quo, because the main contribution is in terms of the new effects we have discovered.

Arguably, a bigger contribution is being able to organise each of these new effects, and devise experiments to test for them quantitatively. Having clear examples of new/interesting/existing effects then act as a useful contribution in their own right, as well as acting as a proof of concept / usefulness for the tooling and methodology.

It's reasonable to assert that there are potentially hundreds/thousands of different combinations of device, micro-architectural leakage source and methods of exploitation. The value of finding any given one of these is hence small, given the total problem space (this sort of follows from existing literature, where many papers appear each detailing a small effect). The real value then comes from making it easy to explore the problem space, and organise the results of that exploration.

Qualitative:
- Raise awareness of implementation difficulties across the literature, and bridge the gap between more "theoretical" leakage papers v.s. empirical studies of leakage effects.
- Understand how the same *code* can leak differently across different devices.
- Understand how the same *action* (syntactically different but semantically identical code) can leak differently across different devices.
- Understand what the most important questions are about a device from the perspective of it's behavior under leakage analysis.
- Enable a 3rd party to contribute information on a device, or pose a new / relevant experiment.

Tooling:
- Create a set of micro-benchmarks which probe *specific* pieces of functionality about a range of devices.
  - Ideally, each benchmark yields either a yes/no answer to a question of the form "Does device X exhibit leakage when executing this particular code-idiom"
  - Care should be taken to avoid questions which tempt comparisons of the "Device X leaks *more/less* than device Y". The current methods of leakage in the literature do not support such comparisons.

Methodology:
- A tool flow that is totally separable from the devices and experiments.
- Create a standardised flow for running said benchmarks on different devices and collating their results *in an actionable way*.
- It should be *trivial* for individuals / organisations to add both new devices and new benchmarks.
  - Present results such that the community can add to them over time.

Systematization of Knowledge:
- Given a set of benchmarks and a standardised flow for executing them, create a database of as many different devices and their analysis results as possible.
- Engineers/Researchers can then query the database:
  - For a given benchmark, how do all devices behave under it?
  - For a given device, what key leakage phenomena should I be aware of when writing leakage resilient code for it?
  - Does this device behave in ways that transparently undermine my proof of security?
  - Give some unexpected leakage in my implementation, which known effects in this device might be the cause?
  - How can / is this source of leakage be exploited? Do I as an engineer need to worry about it?
  - Which parts of the academic literature are relevant to this device or effect?

## Complimentary work streams

There are obvious tie-ins to this as a project with the SCA3S.
- SCA3S will already act as a way of easily running simple (and more complex) leakage analysis jobs.
- It will certainly be able to handle the kind of "yes/no" feature questions which the envisaged benchmarks aim to answer.
- Having the sort of "device leakage profile" which the flow aims to provide for each device available through SCA3S seems to inherently add value to SCA3S as a platform.
- If an end goal of SCA3S is to let people run their own FPGA soft-cores through it, letting them do a "push-button" leakage phenomenon profile of their device seems useful.

## Conclusions & Other Remarks

- Trying to find more and more interesting / esoteric sources of leakage from micro-architectures is useful in and of itself, but as an approach to research potentially misses the wood for the trees.
- We already have a number of useful / interesting / novel effects of our own to present, plus the past body of literature on the subject.
- What, as a community, is needed, is a way to systematically share and build on that knowledge.
- As a team in Bristol, we're good at automation.
  - This is somewhat forced on us due to the small size (in people) of the project.
  - By properly building out our tool flow this way (as with other projects), life will be made much easier in the future.
- While this pseudo-proposal stops just short of world domination and solving `p/=np`, by breaking the problem into tooling, experiments and data aggregation, we stand a reasonably good chance of pulling it off because we're building on tools we already have.
  - Once the tool flow is built in a robust way, adding new experiments and devices then becomes trivial.
  - It also helps as a way of creating concrete examples of effects alluded too in the literature.

