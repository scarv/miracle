#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER
    
    xor t0, t0, t0      // Clear t0

    NOP_SPACER

    xor t0,a0,t0        // Secret value on LHS of xor
    sll t1,a1,31        // Secret value on LHS of sll

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
