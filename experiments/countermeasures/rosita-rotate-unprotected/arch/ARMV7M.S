#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    NOP_SPACER

    mov r2, #24     // Amount to rotate by

    ror r0, r2      // Rotate

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
