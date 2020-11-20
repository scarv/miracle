#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // r5 - TTest Var 1
                        // r6 - TTest Var 2
                        // r7 - TTest Var 3
                        // r8 - TTest Var 4

    FUNC_ENTER_SHORT

    xor     r9,r9,r9

    NOP_SPACER
    
    bri     branch_tgt  // Always branch
    xor     r5,r5,r6

    NOP_SPACER

branch_tgt:
    xor     r7,r7,r8
    
    NOP_SPACER

    FUNC_RETURN_SHORT

.global experiment_payload_end
experiment_payload_end: nop
