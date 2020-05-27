#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r8,r8,r8
    xor r7,r7,r7

    // Flush load data path
    lbui r8,r5,0

    NOP_SPACER

    // Load TTest Variable
    lbui r7,r6,0

    NOP_SPACER

    // Flush load data path again.
    lbui r8,r5,0

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
