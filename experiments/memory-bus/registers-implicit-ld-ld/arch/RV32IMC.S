#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor t0,t0,t0    // Clear load instruction destination
    xor t1,t1,t1    // registers.

    NOP_SPACER

    lw a1,0(a1)     // Load TTest variable 1
    xor t1,t1,t1;   // Try to clear ALU datapath
    lw a2,0(a2)     // Load TTest variable 2

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
