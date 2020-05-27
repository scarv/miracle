#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor a3,a3,a3
    xor a2,a2,a2

    // Flush load data path
    NOP_SPACER

    lhu a3,0(a0)

    NOP_SPACER

    // Load TTest Variable
    lhu a2,0(a1)

    NOP_SPACER

    // Flush load data path again.
    lhu a3,0(a0)

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
