
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

[Back Home](../../README.md)
