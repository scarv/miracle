#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // r0 = TTest variable 1 
                        // r1 = loop stop count
    FUNC_ENTER          // r2 = loop increment
                        // r3 = TTest variable 2
    eor r4,r4           // r4 = loop counter
                                                   
    loop_0:                                        
                                                   
        mov r1, r1      // Used to clear pipeline registers.
        mov r1, r1
        mov r1, r1
        mov r1, r1
        mov r1, r1
                                                   
        add r4,r4,r2    // Increment loop counter
                                                   
        cmp r4, r1      // Finish the loop?
        bne loop_0      // Branch up
                                                   
    eor r0,r0           // Operate on secret value 1.
    eor r3,r3           // Operate on secret value 2.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

