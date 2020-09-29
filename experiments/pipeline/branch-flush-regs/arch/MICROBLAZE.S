#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // r5 - TTest Var 1
                        // r6 - TTest Var 2

    FUNC_ENTER_SHORT

    xor     r7,r7,r7    // Clear r7
    xor     r8,r8,r8    // Clear r8

    NOP_SPACER
    
    xor     r7,r7,r5    // load r5 into pipeline regs
    beqi    r7, branch_tgt  // Always branch

    NOP_SPACER

branch_tgt:
    
    xor     r8,r8,r6    // load r6 into pipeline regs
    
    NOP_SPACER

    FUNC_RETURN_SHORT

.global experiment_payload_end
experiment_payload_end: nop
