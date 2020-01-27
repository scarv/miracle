#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi r1,r1,-16

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    lwi r9,r5,0
    lwi r10,r6,0

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    swi r7,r1,4
    lwi r7,r1,4

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    lwi r9,r5,0

    swi r7,r1,4
    lwi r7,r1,4

    lwi r10,r6,0

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    addi r1,r1,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
