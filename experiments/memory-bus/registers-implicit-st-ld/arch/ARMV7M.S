#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r4,r4       // Clear load instruction destination
    eor r5,r5       // registers.

    NOP_SPACER

    str r3,[r2,#0]  // Store TTest variable 2 over zeros
    eor r5,r5;          // Try to clear ALU datapath
    ldr r5,[r1,#0]      // Load TTest variable 1

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
