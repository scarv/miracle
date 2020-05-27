#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r9, r9, r9      // Clear r9

    NOP_SPACER

    xor r9,r5,r9        // Secret value on LHS of xor
    bsrli r10,r6,31     // Secret value on LHS of bsrli

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
