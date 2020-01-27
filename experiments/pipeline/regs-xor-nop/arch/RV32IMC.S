#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    NOP_SPACER

    xor t0,a0,a0
    nop
    xor t1,a1,a1

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
