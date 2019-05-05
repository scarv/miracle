# NOP Instructions

[Kaufmann et al.](https://doi.org/10.1007/978-3-319-48965-0_36)
describe an timing attack on Curve25519.  The attack is based on
what couldn be described as the "security unaware translation" of
intended semantics into an associated concrete, executable form.
In short, on their experimental platform the tool chain compiles
an $( 64 \times 64 )$-bit integer multiplication *instruction*
into use of a Windows run-time library *function*; the function
implements a form of early-termination, leading to data-dependent
execution time and hence information leakage which is capitalised
on by the attack.

Considering this concept in a general sense, similar examples can
be identified at various levels of software and hardware.  For
example:

- An assembler will typically support a suite of target-dependent
  pseudo-instructions; said instructions essentially act as macros,
  and are translated into a (sequence of) concrete instructions by
  the assembler.  Sometimes pseudo-instructions are used as a form
  of short-hand for complex and/or common tasks; sometimes they
  are used to avoid requiring a dedicated concrete instruction in
  order to provide some operation.

- Some micro-architectures employ forms of micro-op fusion and/or
  fission.  In either case, the underlying premise is that a given
  instruction (sequence) may not be executed in an intuitive way;
  this allows various forms of optimisation, e.g., as a means of
  maximising execution unit utilisation.

A no-operation (or NOP) is a good example: associated semantics may
be delivered by a dedicating encoding, or through use of an existing
instruction whose semantics are the same.  Likewise, processor cores
may execute NOPs in different ways; for example, they may or may not
be squashed at the decode stage.

Questions:

1. For each target (processor plus tool-chain), can we produce some
   form of systematic survey of, e.g., pseudo-instructions; in some
   cases, the ISA itself might specify/assume examples.

2. Given mismatch between specification and (translated) execution,
   is it possible to identify cases where leakage characteristics
   will differ; are there potentially exploitable instances (e.g.,
   a NOP leaking wrt. register reads that shouldn't exist from an
   intuitive perspective).

   For example, MIPS apparently has an abs pseudo-instruction that
   translates to a sequence including a data-dependent branch!

3. How can this issue be addressed, in a) existing platforms (e.g.,
   via "security *aware* translation") or b) new platforms (e.g.,
   rules or principles, such as eliminating any such examples).

4. Can we identify how a NOP is implemented on a particular target.
5. Is a NOP distinct from other instructions?
6. Do NOP instructions inadvertently read registers?
7. Are there other instructions more suitable for creating pipeline
   leakage barriers than the defined NOP for a given architecture
   or for a particular CPU?

---

[Back Home](../../README.md)

