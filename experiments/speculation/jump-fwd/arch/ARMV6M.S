#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:         // r0 - pointer to d1..d6 array.

    FUNC_ENTER

    ldr r5,[r0,#(5*4)]      // Load sensitive values
    ldr r4,[r0,#(4*4)]
    ldr r3,[r0,#(3*4)]
    ldr r2,[r0,#(2*4)]
    ldr r1,[r0,#(1*4)]
    ldr r0,[r0,#(0*4)]
    eor r7, r7              //  zero r7
    eor r7, r7              //  

branch_start:
    TEN_TIMES(eor r7 COMMA r7)
    eor r0, r1              // Secret vars 0,1
    b   target_address      // Always jump
    eor r2, r3
    eor r4, r5

target_address:
    TEN_TIMES(eor r7 COMMA r7)
    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

