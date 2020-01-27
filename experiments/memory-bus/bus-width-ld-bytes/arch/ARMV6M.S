#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    eor r3,r3
    eor r2,r2

    NOP_SPACER

    // Flush load data path
    ldrb r3,[r0,#0]

    NOP_SPACER
    
    // Load TTest Variable
    ldrb r2,[r1,#0]

    NOP_SPACER

    // Flush load data path again.
    ldrb r3,[r0,#0]

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
