#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r0 - TTest variable di1
                        // r1 - TTest variable di2
    NOP_SPACER          // r2 - TTest variable di3
                        // r3 - TTest variable di4

    b branch_start

target_address:
    NOP_SPACER
    FUNC_RETURN

branch_start:
    NOP_SPACER
    cmp r4, r4
    beq target_address  // Always jump
    add r0, r0
    add r1, r1
    add r2, r2
    add r3, r3

.global experiment_payload_end
experiment_payload_end: nop

