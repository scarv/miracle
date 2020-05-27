#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    NOP_SPACER

    str r2,[r0,#0]  // Store TTest var 1 to idx 1
    
    NOP_SPACER

    eor r5, r5      // Try to flush ALU data path
    
    NOP_SPACER

    str r3,[r1,#0]  // Store TTest var 2 to idx 2
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
