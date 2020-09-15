#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER
    
    NOP_SPACER

    strb r1,[r0,#2]
    strb r2,[r0,#3]
    strb r3,[r0,#4]

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
