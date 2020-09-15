#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r0 - TTest variable di1
                        // r1 - TTest variable di2
    NOP_SPACER          // r2 - TTest variable di3
                        // r3 - TTest variable di4

    b   target_address
    add r0, r0
    add r1, r1
    add r2, r2
    add r3, r3

target_address:
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

