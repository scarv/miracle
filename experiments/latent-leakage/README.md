
# Latent Execution Leakage

**This is Dan's "spectre for side-channels" idea.**

In an `N` length pipeline (without considering branch prediction for now)
control flow changes are *taken* in the very last stage.
This has several implications:

- There are upto `N-1` instructions in varying stages of
  completion in preceeding stages.

- There may be results already computed from secret date in a pipeline
  register about to be thrown away.

- There may be secret operands which have been read but not computed on
  in a pipeline register about to be thrown away.

In large super-scalar / out-of-order CPUs, it was possible for
un-committed instructions to influence micro-architectural state in an
architecturally detectable way. This gave rise to spectre and meltdown.

In a single-issue, in-order, pipelined CPU *without perfect branch
prediction*, it is *inevitable* that some instructions will progress through
the pipeline and be partially executed in the shadow of a taken control
flow change.

**Questions:**

1. Can we identify the presence of these instructions using side-channel
   leakage information?

   - Can we exploit whatever leakage they produce?

   - If we cannot observe this leakage, why might that be?

2. Does such leakage contribute to "ghost" leakage observed in the past,
   where certain values continue to leak long after they are "finished"
   with.

3. How likely is this sort of leakage to occur?

---

# Experiments

Step 1: Profiling instructions
- Select some possible attackable instruction we expect to appear in the
  shadow of a branch: add/xor/shift etc.
- Create templates for these instructions operating on known data, or
- just use hamming weight estimates for the data they operate on.

Step 2: identifying branch shadow length
- For each attackable instruction `I`
- Create an instruction sequence {NOPS, `I`, NOPS\*N,`J`,NOPS}
  where `J` is a control flow change.
- Run a fixed v.s random t-test on the sequence for varying values of `N`.
  - If there is no leakage, then the instruction is not present in the
    pipeline when the branch executes.
  - If there is leakage then we have observed leakage from an instruction
    which *has not* executed.

Notes:
- Does the leakage stop appearing immediately after the branch is taken,
  or does it continue after it as well?
  - If no, this implies any intermediate values being computed on are
    cleared from the pipeline on a branch.
  - If yes, this implies the values are *not* cleared, and continue down
    the pipeline, but are not comitted to architectural state at the end.
- Does clearing or leaving the intermediate values in the pipeline
  increase or decrease total leakage?

---

[Back Home](../../README.md)
