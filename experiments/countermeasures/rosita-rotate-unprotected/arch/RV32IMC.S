#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // a0 = value to rotate
                        // a1 = mask
    NOP_SPACER

    srli t1, a0, 24     // Rotate value
    slli a0, a0, 8
    or a0, a0, t1
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
