
# AES SBOX Experiment

## Purpose

To quantify the effect of extra bytes being fetched on a CPA attack on
an AES SBox.

**Method:**
- Create a partial AES implementation:
  - Just implement the Add Round Key and SBox functions
  - The implementation can be fed 16 bytes of message and 16 bytes of key.
- Run a TTest using the standard TVLA process / fixed values
  - Show that there is leakage.
- Run two CPA attacks on the device:
  - First, do a standard byte-by-byte attack using only the single bytes
    being loaded.
  - Second, do an attack which incorperates the expected leakage from
    entire fetched words of the SBox.

**Expectations:**
- We should see that using the extra information in the fetched memory
  word, the attack should succeed with fewer traces, or gain higher
  confidence with the same number of traces.

## Running the experiment
