#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    add sp,#-16

    NOP_SPACER      // Variant 2, overwrite stack countermeasure

    str r2,[sp,#4]  // Store random variable to stack
    str r0,[r3,#0]  // Store TTest variable 1 to location X
    str r2,[sp,#4]  // Store random variable to stack
    str r1,[r3,#4]  // Store TTest variable 2 to locaton X
    
    NOP_SPACER      // Barrier

    add sp,#16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
