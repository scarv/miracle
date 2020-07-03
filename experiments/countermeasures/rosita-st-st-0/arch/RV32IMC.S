#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi sp,sp,-16

    NOP_SPACER          // Variant 1, expect leakage
                                                                      
    sw a0,0(a3)         // Store TTest variable 1
    sw a1,4(a3)         // Store TTest variable 2
                                                                      
    NOP_SPACER          // Barrier

    addi sp,sp,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
