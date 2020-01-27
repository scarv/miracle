#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // r0 = TTest variable 1 
                        // r1 = loop stop count
    FUNC_ENTER          // r2 = loop increment
                        // r3 = TTest variable 2
    eor r4,r4           // r4 = loop counter
                                                   
    loop_0:                                        
                                                   
        NOP_SPACER                                 
                                                   
        add r4,r4,r2    // Increment loop counter
                                                   
        cmp r4, r1      // Finish the loop?
        bne loop_0      // Branch up
                                                   
    eor r6,r0           // Operate on secret value 1.
    eor r6,r3           // Operate on secret value 2.

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

