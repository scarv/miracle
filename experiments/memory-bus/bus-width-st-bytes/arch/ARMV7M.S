#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    // Clear the register we will write to memory
    eor r2,r2

    NOP_SPACER

    // Zero the store data path
    strb r2,[r0,#0]

    NOP_SPACER

    // Store zero and overwrite TTest var in memory.
    strb r2,[r1,#0]

    NOP_SPACER

    // Zero the store data path
    strb r2,[r0,#0]

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
