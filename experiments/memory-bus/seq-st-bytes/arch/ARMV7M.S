#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    NOP_SPACER

    strb r1,[r0,#0]
    strb r2,[r0,#1]
    strb r3,[r0,#2]
    strb r1,[r0,#3]
    strb r2,[r0,#4]
    strb r3,[r0,#5]

    NOP_SPACER

    eor r1, r1
    eor r2, r2
    eor r3, r3

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
