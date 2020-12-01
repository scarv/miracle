#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // a6 = loop counter
                        // a0 = sensitive value array.
    FUNC_ENTER

    lw a5, 5*4(a0)      // Load sensitive values
    lw a4, 4*4(a0)
    lw a3, 3*4(a0)
    lw a2, 2*4(a0)
    lw a1, 1*4(a0)
    lw a0, 0*4(a0)
    li  a6, 10          // loop 10 times.
    li  a7, 0
                                                           
    loop_0:                                                
        xor a7, a7, a5
        li a7, 0
        addi a6, a6, -1         // decrement loop counter
        bnez a6, loop_0         // Finish the loop?

    xor a0, a0, a1          // operate on secret vars
    xor a2, a2, a3
    xor a4, a4, a5

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
