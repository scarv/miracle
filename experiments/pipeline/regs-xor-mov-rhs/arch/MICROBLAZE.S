#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r11,r11,r11     // Clear r11, r12
    xor r12,r12,r12

    NOP_SPACER

    xor r9,r9,r5        // TTest Var 1 on RHS of xor
    ori r11, r12, 0     // MOV barrier
    xor r10,r10,r6      // TTest Var 2 on RHS of xor

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
