#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    li  a1, 0
    li  a2, 0
    li  a3, 0
    li  a4, 0
    li  a5, 0

    NOP_SPACER

    lbu a1, 2(a0)
    lbu a2, 3(a0)
    lbu a3, 4(a0)
    lbu a4, 5(a0)
    lbu a5, 6(a0)
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
