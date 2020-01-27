#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r9,r9,r9;

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        cmp r11, r9, r7
        bnei r11, branch_target
        beqi r11, branch_target

        xor r9,r6,r5

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    branch_target:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
