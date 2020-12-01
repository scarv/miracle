#include "kernel-macros.h"

.syntax unified

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
    eor r6, r6              //  zero r6
    eor r6, r6              //  

    b branch_start

target_address:
    TEN_TIMES(eor r6 COMMA r6)
    FUNC_RETURN

branch_start:
    TEN_TIMES(eor r6 COMMA r6)
    cmp r6, r6              // compare (0,0) -> always equal.
    EOR.W r0, r0,r1           // Secret vars 0,1 - .w to not update flags.
    beq target_address      // Always jump
    eor r2, r3
    eor r4, r5

.global experiment_payload_end
experiment_payload_end: nop

