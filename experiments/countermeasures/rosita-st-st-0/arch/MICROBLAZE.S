#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi r1,r1,-16

    NOP_SPACER      // Variant 1, expect leakage
                                                                  
    swi r5,r8,0     // Store TTest variable 1
    swi r6,r8,4     // Store TTest variable 2
                                                                  
    NOP_SPACER      // Barrier

    addi r1,r1,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
