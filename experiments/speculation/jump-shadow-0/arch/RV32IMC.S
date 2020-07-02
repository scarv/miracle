#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // a0 - TTest variable di1
                        // a1 - TTest variable di2
    NOP_SPACER          // a2 - TTest variable di3
                        // a3 - TTest variable di4

    test_0:
        j test_end      // Branch to test_end - jump over secret clearing
        xor a0,a0,a0    // Clear secret value a0
        xor a1,a1,a1    // Clear secret value a1
        xor a2,a2,a2    // Clear secret value a2
        xor a3,a3,a3    // Clear secret value a3

        NOP_SPACER

    test_end:

        NOP_SPACER
            
        xor a0,a0,a0    // Clear secret value a0
        xor a1,a1,a1    // Clear secret value a1
        xor a2,a2,a2    // Clear secret value a2
        xor a3,a3,a3    // Clear secret value a3

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

