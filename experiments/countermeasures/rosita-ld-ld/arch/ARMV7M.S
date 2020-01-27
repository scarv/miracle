#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    add sp,#-16

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    ldr r4,[r0,#0]
    ldr r5,[r1,#0]

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    str r2,[sp,#4]
    ldr r2,[sp,#4]

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    ldr r4,[r0,#0]

    str r2,[sp,#4]
    ldr r2,[sp,#4]

    ldr r5,[r1,#0]

    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop;

    add sp,#16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
