#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor t0,t0,t0

    loop_0:

        nop; nop; nop; nop; nop; nop; nop; nop;
        nop; nop; nop; nop; nop; nop; nop; nop;

        add t0,t0,a2

            bne t0, a1, loop_0

    xor t2,t2,a0

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
