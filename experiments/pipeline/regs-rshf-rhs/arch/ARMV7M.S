#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r4, r4      // Clear r4

    NOP_SPACER

    eor r4,r0       // Secret value on RHS of eor
    lsr r5,r1,#31   // Secret value on LHS of LSR

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
