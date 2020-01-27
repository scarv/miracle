#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                                // r5 = TTest variable 1
    FUNC_ENTER                  // r6 = TTest variable 2
                                // r7 = Branch or not?
    xor r9,r9,r9;               // Clear r9

    NOP_SPACER

    cmp r11, r9, r7             // Should we branch?
    bnei r11, branch_target
    beqi r11, branch_target

    xor r9,r9,r5                // Manipulate secret variable 0
    xor r9,r9,r6                // Manipulate secret variable 1

    NOP_SPACER

    branch_target:

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
