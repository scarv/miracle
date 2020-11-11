#include "kernel-macros.h"

.syntax unified

.text

.global experiment_payload
experiment_payload: // r0 - uint32_t di1
                    // r1 - uint32_t di2
    FUNC_ENTER      // r2 - uint32_t di3
                    // r3 - uint32_t di4

    NOP_SPACER

    eor r0, r1      // di1 = di1 ^ di2
    ror r2, r2, #8  // di3 = di3 >>> 8
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
