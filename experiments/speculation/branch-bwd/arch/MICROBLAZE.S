#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r5 - TTest variable di1
                        // r6 - TTest variable di2
                        // r7 - TTest variable di3
                        // r8 - TTest variable di4

    bri branch_start

target_address:
    NOP_SPACER
    FUNC_RETURN

branch_start:
    NOP_SPACER
    beqi r0, target_address // Always jump. beqi - branch if r0=0
    add r5, r5, r5
    add r6, r6, r6
    add r7, r7, r7
    add r8, r8, r8

.global experiment_payload_end
experiment_payload_end: nop

