#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r4,r4       // Clear load instruction destination
    eor r5,r5       // registers.

    NOP_SPACER

    ldr r4,[r0,#0]  // Clear load data path

    NOP_SPACER
    
    ldr r5,[r1,#0]  // Load TTest variable 1

    NOP_SPACER

    eor r5,r5;      // Try to clear ALU datapath

    NOP_SPACER
    
    str r5,[r2,#0]  // Store 0 over TTest variable 2

    NOP_SPACER

    ldr r4,[r0,#0]  // Clear load data path

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
