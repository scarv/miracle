#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r1, r1
    eor r2, r2
    eor r3, r3
    eor r4, r4
    eor r5, r5

    NOP_SPACER

    ldrb r1,[r0,#2]
    ldrb r2,[r0,#3]
    ldrb r3,[r0,#4]
    ldrb r4,[r0,#5]
    ldrb r5,[r0,#6]

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
