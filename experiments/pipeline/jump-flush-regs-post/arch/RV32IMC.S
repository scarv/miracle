#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // a0 - TTest Var 1
                        // a1 - TTest Var 2

    FUNC_ENTER

    xor     a2,a2,a2    // Clear r7

    NOP_SPACER
    
    j       branch_tgt  // Always branch
    xor     a2,a0,a0    // load a0 into pipeline regs

    NOP_SPACER

branch_tgt:
    
    xor     a2,a1,a1    // load a1 into pipeline regs
    xor     x0,x0,x0
    
    NOP_SPACER

    xor     a0, a0, a0
    xor     a1, a1, a1
    xor     a2, a2, a2

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
