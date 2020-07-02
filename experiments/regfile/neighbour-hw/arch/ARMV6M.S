#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r0 - TTest variable.
                    // r1 - variable d2.
    FUNC_ENTER      // r2 - variable d3.
                    // r3 - variable d4.

    eor     r4, r4
    eor     r5, r5
    eor     r6, r6
    eor     r7, r7

    NOP_SPACER
    NOP_SPACER

    eor     r4, r4
    eor     r5, r5
    eor     r6, r6
    eor     r7, r7
    eor     r4, r5
    eor     r5, r6
    eor     r6, r7
    eor     r7, r4
    eor     r4, r6
    eor     r5, r7
    eor     r6, r4
    eor     r7, r5
    
    NOP_SPACER
    NOP_SPACER

    eor     r0, r0
    eor     r1, r1
    eor     r2, r2
    eor     r3, r3

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
