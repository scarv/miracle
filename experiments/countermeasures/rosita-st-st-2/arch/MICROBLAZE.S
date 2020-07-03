#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi r1,r1,-16

    NOP_SPACER      // Variant 3, overwrite destination address X
                                                                  
    swi r7,r8,0     // Store random variable to location X
    swi r5,r8,0     // Store TTest variable 1 to location X
    swi r7,r8,4     // Store random variable to locaton X
    swi r6,r8,4     // Store TTest variable 2 to location X

    NOP_SPACER

    addi r1,r1,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
