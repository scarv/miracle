#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi sp,sp,-16

    NOP_SPACER          // Variant 3, overwrite destination address X
                                                                      
    sw a2,0(a3)         // Store random variable to location X
    sw a0,0(a3)         // Store TTest variable 1 to location X
    sw a2,4(a3)         // Store random variable to locaton X
    sw a1,4(a3)         // Store TTest variable 2 to location X

    NOP_SPACER

    addi sp,sp,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
