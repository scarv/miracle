#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                                // a0 = TTest variable 1
    FUNC_ENTER                  // a1 = TTest variable 2
                                // a2 = Branch or not?
    xor t0,t0,t0;               // Clear t0

    NOP_SPACER

    bnez a2, branch_target      // Should we branch?
    beqz a2, branch_target

    xor t0,t0,a0                // Manipulate secret variable 0
    xor t0,t0,a1                // Manipulate secret variable 1

    NOP_SPACER

    branch_target:

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
