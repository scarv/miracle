#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r5 - uint32_t di1
                    // r6 - uint32_t di2
    FUNC_ENTER      // r7 - uint32_t di3

    andi r8, r0, 0
    andi r8, r0, 0

    NOP_SPACER

    xor r8, r6, r7
    xor r8, r7, r5

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
