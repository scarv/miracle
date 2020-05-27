#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r9 ,r9 ,r9      // Clear r9, r10
    xor r10,r10,r10     //

    NOP_SPACER

    xor r9 ,r9 ,r5      // Secret values on RHS of xor
    xor r10,r10,r6

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
