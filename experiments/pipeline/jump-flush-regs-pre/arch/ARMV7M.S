#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // r0 - TTest Var 1
                        // r1 - TTest Var 2

    FUNC_ENTER

    eor     r2,r2       // Clear r2

    NOP_SPACER
    
    eor     r0,r2       // r0 ^= r2 - load r0 into pipeline regs
    b       branch_tgt  // Always branch

    NOP_SPACER

branch_tgt:
    
    eor     r1,r2       // r1 ^= r2 - load r1 into pipeline regs
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
