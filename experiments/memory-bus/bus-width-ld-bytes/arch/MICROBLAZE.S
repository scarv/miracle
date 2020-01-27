#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r8,r8,r8
    xor r7,r7,r7

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    lbui r8,r5,0
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    lbui r7,r6,0
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    lbui r8,r5,0
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
