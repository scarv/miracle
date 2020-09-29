#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r0 - TTest variable di1
                        // r1 - TTest variable di2
    
    TEN_TIMES(eor r2 COMMA r2)

    cmp r4, r4
    beq target_address  // Always jump
    add r0, r0
    add r1, r1
    add r2, r2
    add r3, r3

target_address:
    TEN_TIMES(eor r2 COMMA r2)

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

