#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // a0 - uint32_t di1
                    // a1 - uint32_t di2
    FUNC_ENTER      // a2 - uint32_t di3
                    // a3 - uint32_t di4

    NOP_SPACER

    xor  a0, a0, a1 // di1 = di1 ^ di2
    srli a2, a3, 8  // di3 = di4 >> 8
    slli t0, a3, 24 // di3 = di4 >> 8
    or   a2, a2, t0

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
