#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    add sp,#-16

    NOP_SPACER      // Variant 1, expect leakage

    str r0,[r3,#0]  // Store TTest variable 1
    str r1,[r3,#4]  // Store TTest variable 2

    NOP_SPACER      // Barrier

    add sp,#16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
