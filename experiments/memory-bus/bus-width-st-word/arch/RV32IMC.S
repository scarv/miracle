#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    // Clear the register we will write to memory
    xor a2,a2,a2

    NOP_SPACER

    // Zero the store data path
    sw a2,0(a0)

    NOP_SPACER

    // Store zero and overwrite TTest var in memory.
    sw a2,0(a1)

    NOP_SPACER

    // Zero the store data path
    sw a2,0(a0)

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
