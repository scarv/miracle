#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi sp,sp,-16
    xor t0, t0, t0
    sw  t0,0(sp)        // Clear load data path
    lw  t0,0(sp)        // Clear load data path

    NOP_SPACER          // Variant 1: unprotected
                        // Expect leakage here
    lw t0,0(a0)         // Load TTest variable 1
    lw t1,0(a1)         // Load TTest variable 2

    NOP_SPACER          //

    addi sp,sp,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
