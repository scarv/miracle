#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi sp,sp,-16
    
    NOP_SPACER          // Variant 2, overwrite stack countermeasure
                                                                      
    sw a2,4(sp)         // Store random variable to stack
    sw a0,0(a3)         // Store TTest variable 1 to location X
    sw a2,4(sp)         // Store random variable to stack
    sw a1,4(a3)         // Store TTest variable 2 to locaton X
                                                                      
    NOP_SPACER          // Barrier

    addi sp,sp,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
