#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER              // r5 = value to rotate
                            // r6 = mask
    NOP_SPACER

    xor r5, r5, r6          // Mask value being rotated

    bsrli r7, r5, 24        // Rotate value
    bslli r5, r5, 8
    or r5, r5, r7
    
    bsrli r8, r6, 24        // Rotate mask
    bslli r6, r6, 8
    or r6, r6, r8

    xor r5, r5, r6          // Unmask

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
