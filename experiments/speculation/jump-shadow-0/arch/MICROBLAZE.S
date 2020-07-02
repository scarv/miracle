#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r5 - TTest variable di1
                        // r6 - TTest variable di2
    NOP_SPACER          // r7 - TTest variable di3
                        // r8 - TTest variable di4

    test_0:
        bri test_end    // Branch to test_end - jump over secret clearing
        xor r5,r5,r5    // Clear secret value R5
        xor r6,r6,r6    // Clear secret value R6
        xor r7,r7,r7    // Clear secret value R7
        xor r8,r8,r8    // Clear secret value R8
        
        NOP_SPACER

    test_end:

        NOP_SPACER
        
        xor r5,r5,r5    // Clear secret value R5
        xor r6,r6,r6    // Clear secret value R6
        xor r7,r7,r7    // Clear secret value R7
        xor r8,r8,r8    // Clear secret value R8

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

