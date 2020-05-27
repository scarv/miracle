#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi sp,sp,-16
    
    NOP_SPACER          // Variant 4: protected, store flush only
                        // Expect no leakage here
    lw t0,0(a0)         // Load TTest variable 1
    sw a2,4(sp)         // Store random variable to stack
    lw t1,0(a1)         // Load TTest variable 2
                        
    NOP_SPACER          

    addi sp,sp,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
