#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r4,r4

    loop_0:

        nop; nop; nop; nop; nop; nop; nop; nop;
        nop; nop; nop; nop; nop; nop; nop; nop;

        add r4,r4,r2

            cmp r4, r1
            bne loop_0

    nop;
    eor r6,r0

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
