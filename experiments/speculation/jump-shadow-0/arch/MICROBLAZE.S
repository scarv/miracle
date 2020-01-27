#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r5 - TTest variable 1
                        // r6 - TTest variable 2
    NOP_SPACER          // r7 - TTest variable 3
                        // r8 - TTest variable 4
    xor r5,r5,r5        // Clear secret value R5 to get a
                        // Baseline for how things leak.
    NOP_SPACER

    test_0:
        bri test_end    // Branch to test 1
        xor r6,r6,r6    // Clear secret value R6
        xor r7,r7,r7    // Clear secret value R7
        xor r8,r8,r8    // Clear secret value R8

    test_end:

        NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

