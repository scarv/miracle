#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // r0 - TTest Var 1
                        // r1 - TTest Var 2

    FUNC_ENTER_SHORT

    mov     r2,r0
    mov     r3,r1
    eor     r0,r0       // Clear r2
    eor     r1,r1       // Clear r3

    TEN_TIMES(eor r0 COMMA r0)
    TEN_TIMES(eor r0 COMMA r0)
    
    cmp     r2, r2
    eor     r0,r2       // r2 ^= r0 - load r0 into pipeline regs
    beq     branch_tgt  // Always branch

    TEN_TIMES(eor r0 COMMA r0)

branch_tgt:
    
    eor     r1,r3       // r3 ^= r1 - load r1 into pipeline regs
    
    TEN_TIMES(eor r0 COMMA r0)

    FUNC_RETURN_SHORT

.global experiment_payload_end
experiment_payload_end: nop
