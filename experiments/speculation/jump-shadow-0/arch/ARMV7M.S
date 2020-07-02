#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // r0 - TTest variable di1
                        // r1 - TTest variable di2
    NOP_SPACER          // r2 - TTest variable di3
                        // r3 - TTest variable di4

    test_0:
        bal  test_end   // Branch to test_end - jump over secret clearing
        eor r0,r0       // Clear secret value R0
        eor r1,r1       // Clear secret value R1
        eor r2,r2       // Clear secret value R2
        eor r3,r3       // Clear secret value R3

        NOP_SPACER

    test_end:

        NOP_SPACER
        
        eor r0,r0       // Clear secret value R0
        eor r1,r1       // Clear secret value R1
        eor r2,r2       // Clear secret value R2
        eor r3,r3       // Clear secret value R3

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

