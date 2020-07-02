#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                                // a0 = TTest variable 1
    FUNC_ENTER                  // a1 = loop stop count
                                // a2 = loop increment
    xor t0,t0,t0                // t0 = loop counter
                                                           
    loop_0:                                                
                                                           
        NOP_SPACER                                         
                                                           
        add t0,t0,a2            // Increment loop counter
        bne t0, a1, loop_0      // Finish the loop?

    xor a0,a0,a0                // Operate on secret value.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
