#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r4,r4       // Clear load instruction destination
    eor r5,r5       // registers.

    NOP_SPACER

    ldr r1,[r1,#0]      // Load TTest variable 1
    eor r5,r5;          // Try to clear ALU datapath
    ldr r2,[r2,#0]      // Load TTest variable 2

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
