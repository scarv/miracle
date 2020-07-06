#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // a0 - uint32_t di1
                    // a1 - uint32_t di2
    FUNC_ENTER      // a2 - uint32_t di3

    andi a3, x0, 0
    andi a3, x0, 0

    NOP_SPACER

    xor a3, a1, a2
    xor a3, a2, a0

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
