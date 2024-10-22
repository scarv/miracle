#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor t0,t0,t0    // Clear load instruction destination
    xor t1,t1,t1    // registers.

    NOP_SPACER

    lw t0,0(a1)     // Load TTest variable 1
    xor t1,t1,t1;   // Try to clear ALU datapath
    sw a3,0(a2)    // Store TTest variable 2 over din[index2], which is zero.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
