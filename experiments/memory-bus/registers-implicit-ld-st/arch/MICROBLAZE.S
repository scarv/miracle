#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r9,r9,r9        // Clear load instruction destination
    xor r10,r10,r10     // registers.

    NOP_SPACER

    lwi r9 ,r6,0        // Load TTest variable 1
    xor r10,r10,r10;    // Try to clear ALU datapath
    swi r8,r7,0      // Store TTest variable 2 over din[index2], which is zero.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
