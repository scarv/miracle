#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    add sp,#-16

    NOP_SPACER          // Variant 2: protected, load & store flush
                        // Expect no leakage from here.
    ldr r4,[r0,#0]      // Load TTest variable 1
    str r2,[sp,#4]      // Flush store path
    ldr r2,[sp,#4]      // Flush load path
    ldr r5,[r1,#0]      // Load TTest variable 2

    NOP_SPACER          //

    add sp,#16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
