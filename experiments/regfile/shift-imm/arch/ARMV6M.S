#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r0 - TTest variable.

    FUNC_ENTER
    mov  r1, r0     // Move r0 to r1
    eor  r0, r0     // clear r0.

    NOP_SPACER

    slli r0, r0, 1  // Shift left zero'd r0 by 1. Does this access r1?
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

