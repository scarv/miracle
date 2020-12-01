#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:         // r5 - pointer to d1..d6 array

    FUNC_ENTER

    lw a5, 5*4(a0)          // Load sensitive values
    lw a4, 4*4(a0)
    lw a3, 3*4(a0)
    lw a2, 2*4(a0)
    lw a1, 1*4(a0)
    lw a0, 0*4(a0)
    
    xor a6, a6, a6       // Clear register a6
    xor a6, a6, a6

    j   branch_start

target_address:
    NOP_SPACER
    FUNC_RETURN

branch_start:
    NOP_SPACER
    xor a0, a0, a1
    beqz x0, target_address // Always jump. beq - branch if r0=0
    xor a2, a2, a3
    xor a4, a4, a5

.global experiment_payload_end
experiment_payload_end: nop

