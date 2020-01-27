#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    add sp,#-16

    NOP_SPACER      // Variant 1, expect leakage

    str r0,[r3,#0]  // Store TTest variable 1
    and r2,r2       // Flush ALU datapath as much as possible.
    str r1,[r3,#0]  // Store TTest variable 2

    NOP_SPACER      // Barrier
    str r2,[sp,#4]  // Flush store datapath

    NOP_SPACER      // Variant 2, overwrite stack countermeasure

    str r2,[sp,#4]  // Store random variable to stack
    str r0,[r3,#0]  // Store TTest variable 1 to location X
    and r2,r2       // Flush ALU datapath as much as possible.
    str r2,[sp,#4]  // Store random variable to stack
    str r1,[r3,#0]  // Store TTest variable 2 to locaton X
    
    NOP_SPACER      // Barrier
    str r2,[sp,#4]  // Flush store datapath

    NOP_SPACER      // Variant 3, overwrite destination address X

    str r2,[r3,#0]  // Store random variable to location X
    str r0,[r3,#0]  // Store TTest variable 1 to location X
    and r2,r2       // Flush ALU datapath as much as possible.
    str r2,[r3,#0]  // Store random variable to locaton X
    str r1,[r3,#0]  // Store TTest variable 2 to location X
    
    NOP_SPACER

    add sp,#16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
