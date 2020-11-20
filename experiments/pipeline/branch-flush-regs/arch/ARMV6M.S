#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // r0 - Var 1
                        // r1 - Var 2
                        // r2 - Var 3
                        // r3 - Var 4

    FUNC_ENTER

    mov r5, #0
    
    TEN_TIMES(eor r5 COMMA r5)

    cmp r4,r4
    eor r0, r1
    beq branch_tgt
    
    TEN_TIMES(eor r5 COMMA r5)

branch_tgt:
    eor r2, r3
    
    TEN_TIMES(eor r5 COMMA r5)


    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
