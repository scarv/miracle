#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:             // a0 = TTest variable 1 
                                // a1 = loop stop count
    FUNC_ENTER                  // a2 = loop increment
                                // a3 = TTest variable 2
    xor t0,t0,t0                // t0 = loop counter
                                                           
    loop_0:                                                
                                                           
        NOP_SPACER                                         
                                                           
        add t0,t0,a2            // Increment loop counter
        bne t0, a1, loop_0      // Finish the loop?

    xor t2,t2,a0                // Operate on secret value 1.
    xor t2,t2,a3                // Operate on secret value 2.

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

