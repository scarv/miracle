#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // a0 - TTest Var 1
                        // a1 - TTest Var 2

    FUNC_ENTER

    xor     a2,a2,a2    // Clear r7

    NOP_SPACER
    
    xor     a2,a0,a0    // load a0 into pipeline regs
    beqz    a2, branch_tgt  // Always branch

    NOP_SPACER

branch_tgt:
    
    xor     a2,a1,a1    // load a1 into pipeline regs
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
