#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r0 - TTest variable.

    FUNC_ENTER
    eor  r3, r3     // clear any pipe registers
    eor  r3, r3     // clear any pipe registers

    NOP_SPACER

    lsr  r3, r3, #0 // Shift left zero'd r3 by 0. Does this access r0?
    lsr  r3, r3, #1 // Shift left zero'd r3 by 1. Does this access r1?
    lsr  r3, r3, #2 // Shift left zero'd r3 by 2. Does this access r2?
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

