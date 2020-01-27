#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    srli a0, a2, 24
    slli t1, a2, 8
    or a0, a0, t1

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
