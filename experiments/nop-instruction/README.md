
# NOP Instructions

Not all NOPs are alike. Different architectures may have different
instructions and conventions for expressing a NOP.
- It may simply be a specific encoding of a pre-existing instruction
  which naturally has no architectural side-effects.
- It may be a dedicated encoding.

Likewise, some CPUs may implement NOP in different ways.
- NOP may not make it out of the decode stage, and hence not
  affect subsequent registers 
  (see [target platforms](../../targets/README.md), scale boards).

Questions:
1. Can we identify how a NOP is implemented on a particular target.
2. Is a NOP distinct from other instructions?
3. Do NOP instructions inadvertantly read registers?
4. Are there other instructions more suitable for creating pipeline
   leakage barriers than the defined NOP for a given architecture
   or for a particular CPU?

---

[Back Home](../../README.md)

