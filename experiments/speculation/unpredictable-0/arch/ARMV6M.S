#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r4,r4;

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        cmp r4, r2
        bne branch_target
        beq branch_target

        eor r4,r0

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    branch_target:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
