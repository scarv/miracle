#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // a0 - TTest variable 1
                        // a1 - TTest variable 2
    NOP_SPACER          // a2 - TTest variable 3
                        // a3 - TTest variable 4
    xor a0,a0,a0        // Clear secret value a0 to get a
                        // Baseline for how things leak.
    NOP_SPACER

    test_0:
        j test_end      // Branch to test 1
        xor a1,a1,a1    // Clear secret value a1
        xor a2,a2,a2    // Clear secret value a2
        xor a3,a3,a3    // Clear secret value a3

    test_end:

        NOP_SPACER

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

