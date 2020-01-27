#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                        // r0 = TTest variable 1
    FUNC_ENTER          // r1 = TTest variable 2
                        // r2 = Branch or not?
    eor r4,r4;          // Clear r4

    NOP_SPACER

    cmp r4, r2          // Should we branch?
    bne branch_target
    beq branch_target

    eor r4,r0           // Manipulate secret variable 0
    eor r4,r1           // Manipulate secret variable 1

    NOP_SPACER

    branch_target:

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
