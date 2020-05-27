#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r6,r6   // Clear r6, r7
    eor r7,r7

    NOP_SPACER

    eor r0,r6   // TTest Var 1 on LHS of xor
    mov r6, r7  // MOV barrier
    eor r1,r7   // TTest Var 2 on LHS of xor

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
