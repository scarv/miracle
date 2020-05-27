#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r4,r4   // Clear r4, r5
    eor r5,r5   //

    NOP_SPACER

    eor r4,r0   // Secret values on RHS of eor
    eor r5,r1
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
