
# Pipeline Registers

Most CPUs are implemented using pipelines. The presence of a pipeline
implies several things about the underlying architecture:
- Instruction execution is spread across time.
- Data-dependent leakage is spread over time.
  - The same value may leak in different places in the trace.
- To prevent RAW hazards, CPUs must either stall, or  *forward* data from
  later stages to earlier stages.

Questions:
1. Can we identify the length of a pipeline just from side-channel
  information?
2. Can we show which information appears in which stage of the pipeline?
   - Expect immediates to appear early.
   - Register read data next.
   - Result data should appear last.
3. Can we identify forwarding paths by looking at side-channel information?
   - Does activation of these paths increase leakage?
4. Can we use this information to inform instruction scheduling choices to
   minimise leakage?

---

# Experiments:

## Pipeline length

Can we work out the length of the pipeline using T-tests and SPA?

Setup:
- Create an instruction sequence at least 4 times the maximum expected
  length of the pipeline.
- In the middle of said sequence, put an instruction which loads a
  large immediate into a register.

Running:
- Do a t-test on the loop, set 1 being a known large immediate value
  and set 2 being random large immediate values.

Analysis:
- The region where there is leakage should show where the data dependent
  leakage occurs.
- Dividing that region by the length of a clock cycle should give the
  length of the pipeline.

Considerations:
- We can expect leakage from not just the CPU pipeline, but also the
  memory hierarchy pipeline.
  - Solution, use an instruction which also reads a known random register
    file value.
  - The leaking region should then begin at the point in the pipeline where
    operands are read. We can how distinguish the length of the memory
    hierarchy pipeline from the CPU "backend" pipeline.
- This assumes a single issue, in order core.

## Pipeline stage identification

Can we identify where in the pipeline computation results will occur?

**Register-Register:**

For each instruction one is interested in:
- Pick known random operands.
- Create hamming weight estimates for the combination of operands
  progressing through a pipeline.
- Create hamming weight estimates for the result of the operation
  progressing through a pipeline.
- Use corrolation analysis to see when operand estimate stops corrolating
  and result estimate starts.

**Register-Memory:**

For each load/store instruction one is interested in:

- Pick known random operands.
- Create hamming weight estimates for the combination of operands
  progressing through a pipeline.
- Create hamming weight estimates for the expected memory address
  progressing through a pipeline.
- Create hamming weight estimates for the data to be loaded/stored
- Use corrolation analysis to see when operand / address estimate stops
  corrolating and result estimate starts.

## Forwarding paths

- Can we identify forwarding paths in the CPU?
- How does pipeline forwarding affect leakage?

**Register Forwarding:**


First, identify a set of useful ALU style instructions: add/xor/shift/mul

Identifying *where* forwarding takes place:
- For each pair of useful ALU instructions:
  - Start with a sequence of NOPs, followed by `I1`, followed by
    `N` > pipeline length NOPS, followed by `I2`, followed by more NOPS.
  - `I2` reads from `I1` destination.
  - Time how long the instruction sequence takes for `N`, `N-1`..`N=0`
    NOP operations between `I1` and `I2`.
  - If the sequence takes `X` cycles for `X` instructions, then either
    there is no forwarding because the instructions were far enough apart
    it was not needed, or forwarding took place transparently and there was
    no need for a stall.
  - If the sequence takes `>X` cycles for `X` instructions, then stalling
    to avoid the RAW hazard must have occured.

Identifying leakage:
- For each of the scenarios above, run a t-test using a single constant
  value to be forwarded v.s a known random value.
- Sort the scenarios based on peak observed leakage?
- Sort scenarios based on *where* peak leakage occurs in the sequence.
- Identify the top-N local maxima in the leakage? Can N correspond to the
  number of pipeline stages the forwarded value traversed?

**Load to use:**

Identifying how far appart instructions must be to avoid load to use
stalls:
- Pick `I1` and `I2` where `I1` is a load and `I2` reads from the destination
  of `I1`.
- Create a sequence of the form {NOPS, `I1`, NOPS\*N,`I2`, NOPS}.
- Time how long it takes to execute the sequence, for varying values of
  `N`.
  - If it takes 1 cycle per instruction, no stalling occured.

Leakage effects:
- Do a t-test on fixed v.s random loaded (and hence forwarded values)

Considerations:
- Assumes no/predictable cache behavior

---

[Back Home](../../README.md)
