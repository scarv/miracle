#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    NOP_SPACER

    sb a1, 0(a0)
    sb a2, 1(a0)
    sb a3, 2(a0)
    sb a1, 3(a0)
    sb a2, 4(a0)
    sb a3, 5(a0)
    
    NOP_SPACER

    xor a1, a1, a1
    xor a2, a2, a2
    xor a3, a3, a3

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
