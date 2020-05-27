#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER
    
    eor r4, r4      // Clear r4

    NOP_SPACER

    eor r0,r4       // Secret value on LHS of eor
    lsl r5,r1,#31   // Secret value on LHS of LSL

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
