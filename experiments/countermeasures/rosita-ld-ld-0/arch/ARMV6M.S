#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    add sp,#-16
    eor r4,r4
    str r4,[sp,#0]      //
    ldr r4,[sp,#0]      // Clear load data path

    NOP_SPACER          // Variant 1: Unprotected
                        // Expect leakage here
    ldr r4,[r0,#0]      // Load TTest variable 1
    ldr r5,[r1,#0]      // Load TTest variable 2

    NOP_SPACER          //

    add sp,#16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
