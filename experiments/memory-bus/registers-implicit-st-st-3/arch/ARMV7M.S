#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r4,r4       // Zero r4

    NOP_SPACER

    str r2,[r0,#0]  // Store TTest var 1 to idx 1
    str r4,[r1,#0]  // Try to flush ALU data path
    str r3,[r0,#0]  // Store TTest var 2 to idx 1
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

