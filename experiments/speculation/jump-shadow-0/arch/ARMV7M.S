#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r0 - TTest variable 1
                        // r1 - TTest variable 2
    NOP_SPACER          // r2 - TTest variable 3
                        // r3 - TTest variable 4
    eor r0,r0           // Clear secret value R0 to get a
                        // Baseline for how things leak.
    NOP_SPACER

    test_0:
        b test_end      // Branch to test 1
        eor r1,r1       // Clear secret value R1
        eor r2,r2       // Clear secret value R2
        eor r3,r3       // Clear secret value R3

    test_end:

        NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

