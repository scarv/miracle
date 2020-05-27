#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor t0, t0, t0  // Clear t0, t1
    xor t1, t1, t1  //

    NOP_SPACER

    xor t0,a0,t0    // Secret values on lhs of xor
    xor t1,a1,t1

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
