#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r0 - uint32_t di1
                    // r1 - uint32_t di2
    FUNC_ENTER      // r2 - uint32_t di3

    eor r3, r3
    eor r3, r3

    NOP_SPACER

    eor r0, r1
    eor r1, r2
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
