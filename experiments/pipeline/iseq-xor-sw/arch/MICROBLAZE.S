#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r5 - uint32_t di1
                    // r6 - uint32_t di2
    FUNC_ENTER      // r7 - uint32_t di3
                    // r8 - uint32_t*di4

    NOP_SPACER

    xor r5, r5, r6 // di1 = di1 ^ di2
    swi r7, r8, 0  // di4 = di3

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
