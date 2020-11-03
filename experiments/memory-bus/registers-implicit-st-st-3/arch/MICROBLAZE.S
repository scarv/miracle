#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    NOP_SPACER

    swi r7,r5,0  // Store TTest var 1 to idx 1
    swi r0,r6,0  // Try to flush ALU data path
    swi r8,r5,0  // Store TTest var 2 to idx 2

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
