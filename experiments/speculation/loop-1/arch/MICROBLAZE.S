#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r9,r9,r9

    loop_0:

        nop; nop; nop; nop; nop; nop; nop; nop;
        nop; nop; nop; nop; nop; nop; nop; nop;

        add r9,r9,r7

            cmp r11, r9, r6
            bnei r11, loop_0

    nop;
    xor r11,r11,r5

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
