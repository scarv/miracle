#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r0 - TTest variable di1.
                    // r1 - TTest variable di2.
                    // r2 - TTest variable di3.

    FUNC_ENTER
    eor  r3, r3     // clear any pipe registers
    eor  r3, r3     // clear any pipe registers

    NOP_SPACER
    add  r3, r3

    lsr  r3, r3, #1  // Shift left zero'd r3 by  1. Does this access r1?
    
    add  r3, r3
    NOP_SPACER

    eor  r0, r0
    eor  r1, r1
    eor  r2, r2

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

