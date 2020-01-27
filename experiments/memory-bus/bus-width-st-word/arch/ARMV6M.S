#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r2,r2

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

    str r2,[r0,#0]
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

    str r2,[r1,#0]

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

    str r2,[r0,#0]

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
