#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    // Clear the register we will write to memory
    xor r7,r7,r7

    NOP_SPACER

    // Zero the store data path
    sbi r7,r5,0

    NOP_SPACER

    // Store zero and overwrite TTest var in memory.
    sbi r7,r6,0

    NOP_SPACER

    // Zero the store data path
    sbi r7,r5,0

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
