#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // a0 - uint32_t di1
                    // a1 - uint32_t di2
    FUNC_ENTER      // a2 - uint32_t di3
                    // a3 - uint32_t*di4

    NOP_SPACER

    xor a0, a0, a1 // di1 = di1 ^ di2
    sw  a2, 0(a3)  // di4 = di3

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
