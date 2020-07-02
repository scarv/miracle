#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:             // r5 = TTest variable 1 
                                // r6 = loop stop count
    FUNC_ENTER                  // r7 = loop increment
                                // r8 = TTest variable 2
    xor r9,r9,r9                // r9 = loop counter
                                                           
    loop_0:                                                
                                                           
        NOP_SPACER                                         
                                                           
        add r9,r9,r7            // Increment loop counter
                                                           
            cmp r11, r9, r6     // Finish the loop?
            bnei r11, loop_0    // Branch up
                                                           
    xor r5, r5, r5              // Operate on secret value 1.
    xor r6, r6, r6              // Operate on secret value 2.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

