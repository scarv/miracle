#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi r1,r1,-16
    xor r9,r9,r9
    swi r9,r1,0         // Clear load data path
    lwi r9,r1,0         // Clear load data path

    NOP_SPACER          // Variant 1: unprotected
                        // Expect leakage here
    lwi r9,r5,0         // Load TTest variable 1
    lwi r10,r6,0        // Load TTest variable 2

    NOP_SPACER          //

    addi r1,r1,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
