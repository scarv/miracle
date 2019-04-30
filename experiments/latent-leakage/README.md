
## Latent Execution Leakage

This is Dan's "spectre for side-channels" idea.

In an `N` length pipeline (without considering branch prediction for now)
control flow changes typically occur in the very last stage.
- This means that there are upto `N-1` instructions in varying stages of
  completion in preceeding stages.

Questions:
1. Can we identify the presence of these instructions using side-channel
   leakage information?
   - Can we exploit whatever leakage they produce?
   - If we cannot observe this leakage, why might that be?
2. Does such leakage contribute to "ghost" leakage observed in the past,
   where certain values continue to leak long after they are "finished"
   with.

---

[Back Home](../../README.md)
