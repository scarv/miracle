#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor t2,t2,t2    // Clear t2, t3
    xor t3,t3,t3

    NOP_SPACER

    xor t0,t0,a0    // TTest Var 1 on RHS of xor
    mv  t2, t3      // MOV barrier
    xor t1,t1,a1    // TTest Var 2 on RHS of xor

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
