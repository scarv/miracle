#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi sp,sp,-16

    NOP_SPACER          // Variant 1: unprotected
                        // Expect leakage here
    lw t0,0(a0)         // Load TTest variable 1
    lw t1,0(a1)         // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    sw a2,4(sp)         // Store random variable to stack
    lw a2,4(sp)         // Load random variable from stack

    NOP_SPACER          // Variant 2: protected, load & store flush
                        // Expect no leakage here
    lw t0,0(a0)         // Load TTest variable 1
    sw a2,4(sp)         // Store random variable to stack
    lw a2,4(sp)         // Load random variable from stack
    lw t1,0(a1)         // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    sw a2,4(sp)         // Store random variable to stack
    lw a2,4(sp)         // Load random variable from stack

    NOP_SPACER          // Variant 3: protected, load flush only
                        // Expect no leakage here
    lw t0,0(a0)         // Load TTest variable 1
    lw a2,4(sp)         // Load random variable from stack
    lw t1,0(a1)         // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    sw a2,4(sp)         // Store random variable to stack
    lw a2,4(sp)         // Load random variable from stack

    NOP_SPACER          // Variant 4: protected, store flush only
                        // Expect no leakage here
    lw t0,0(a0)         // Load TTest variable 1
    sw a2,4(sp)         // Store random variable to stack
    lw t1,0(a1)         // Load TTest variable 2
                        
    NOP_SPACER          

    addi sp,sp,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
