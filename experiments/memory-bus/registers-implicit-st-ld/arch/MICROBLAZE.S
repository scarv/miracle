#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r9,r9,r9
    xor r10,r10,r10

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    lwi r9,r5,0

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    swi r9,r6,0

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop; xor r10,r10,r10;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    lwi r7,r7,0

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    lwi r9,r5,0

    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;
    nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
