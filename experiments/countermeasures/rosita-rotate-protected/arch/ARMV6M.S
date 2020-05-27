#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER      // r0 = value to rotate
                    // r1 = mask
    NOP_SPACER

    mov r2, #24     // Amount to rotate by

    eor r0, r1      // XOR mask with value being rotated
    ror r0, r2      // Rotate value
    ror r1, r2      // Rotate mask
    eor r0, r1      // Un-mask

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
