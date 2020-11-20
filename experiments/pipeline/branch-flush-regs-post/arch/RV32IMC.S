#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // a0 - TTest Var 1
                        // a1 - TTest Var 2
                        // a2 - TTest Var 3
                        // a3 - TTest Var 4

    FUNC_ENTER

    NOP_SPACER
    
    beqz    x0, branch_tgt  // Always branch
    xor     a0,a0,a1

    NOP_SPACER

branch_tgt:
    xor     a2,a2,a3    // load a1 into pipeline regs
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
