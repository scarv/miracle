#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r9,r9,r9        // Clear load instruction destination
    xor r10,r10,r10     // registers.

    NOP_SPACER

    lwi r9,r5,0         // Clear load data path

    NOP_SPACER

    lwi r10,r6,0        // Load TTest variable 1

    NOP_SPACER

    xor r10,r10,r10;    // Try to clear ALU datapath

    NOP_SPACER

    swi r10,r7,0        // Store 0 over TTest variable 2

    NOP_SPACER

    lwi r9,r5,0         // Clear load data path

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
