
# speculation / jump-shadow-0

## Purpose:

Without a branch predictor, almost all scalar CPU pipelines must do
a degree of un-intended speculative exection.

- This is because for a conditional branch, the CPU may assume that
  the branch is (not) taken, and execute accordingly.

- This will fill the pipeline with instructions which (may) need to
  be thrown away.

- It is possible that this sort of behaviour means that instruction
  operands may be read (and even results computed) for instructions which
  from a software perspective are never executed.

- While this behavior is most likely for conditional (and hence harder to
  predict) branches, it possibly occurs for static branches too.

## Method:

- Use four input variables "di0,di1..."

- Execute a branch to relative address instruction (branch immediate)
  which jumps *over* a set of four `xor` instructions.

  - Each xor instruction *zeros* an input variable:

    ```
    xor di0, di0, di0
    xor di1, di1, di1
    xor di2, di2, di2
    xor di3, di3, di3
    ```

- If the first xor instruction enters the pipeline and reads its
  operands, but is later cancelled due to a branch, then we should
  see hamming weight leakage from `di0`.

- If the second xor instruction also enters the pipeline, expect
  hamming weight leakage from `di1`, and hamming distance leakage
  between `di0` and `di1`.

- This continues upto `di3`.

## Expectations:

- If there is no partial execution of the `xor` instructions in the
  shadow of the branches, then there will be no leakage.

- If the instructions enter the pipeline in the shadow of the branch,
  but do not get far enough into the pipeline to start reading their
  operands, there will be no leakage.

- If the instruction enters far enough into the pipeline to read their
  operands, there will be hamming weight leakage.

- If multiple instructions enter far enough into the pipeline, there will
  be hamming distance leakage.

## Running the experiment

To run all stages of the experiment for a particular target device:

```
make -B USB_PORT=[PORT] UAS_TARGET=[TARGET] flow-speculation-jump-shadow-0
```

Where:
- `[PORT]` Is the UART/Serial port to communicate with it over.
- `[TARGET]` Is one of the target names listed in @ref targets

This will run all of the build, program, capture and analyse steps for
the experiment on the specified target.

The individual steps of the experiment are run with the following commands:

- Build: `make build_[TARGET]_speculation-jump-shadow-0`
- Program: `make program_[TARGET]_speculation-jump-shadow-0`
- Capture: `make capture_[TARGET]_speculation-jump-shadow-0 USB_PORT=[PORT]`
- Analyse: `make analyse_[TARGET]_speculation-jump-shadow-0`

*/
