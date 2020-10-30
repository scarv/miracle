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
    li  a6, 0
    li  a7, 0

    NOP_SPACER

    lbu a1, 0(a0)
    lbu a2, 1(a0)
    lbu a3, 2(a0)
    lbu a4, 3(a0)
    lbu a5, 4(a0)
    lbu a6, 5(a0)
    lbu a7, 6(a0)
    
    NOP_SPACER
    
    xor a1,a1,a1
    xor a2,a2,a2
    xor a3,a3,a3
    xor a4,a4,a4
    xor a5,a5,a5
    xor a6,a6,a6
    xor a7,a7,a7

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
