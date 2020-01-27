#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER              // r5 = value to rotate
                            // r6 = mask
    NOP_SPACER

    bsrli r7, r5, 24        // Rotate value
    bslli r5, r5, 8
    or r5, r5, r7

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
