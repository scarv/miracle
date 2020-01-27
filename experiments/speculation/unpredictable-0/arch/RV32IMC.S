#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor t0,t0,t0;

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        bnez a2, branch_target
        beqz a2, branch_target

        xor t0,a1,a0

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    branch_target:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
