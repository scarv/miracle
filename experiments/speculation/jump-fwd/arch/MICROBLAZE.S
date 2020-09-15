#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r5 - TTest variable di1
                        // r6 - TTest variable di2
    NOP_SPACER          // r7 - TTest variable di3
                        // r8 - TTest variable di4

    bri target_address
    add r5, r5, r5
    add r6, r6, r6
    add r7, r7, r7
    add r8, r8, r8

target_address:
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

