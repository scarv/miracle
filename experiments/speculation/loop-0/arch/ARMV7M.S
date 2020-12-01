#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                        // r0 = sensitive value array
    FUNC_ENTER          // r6 = loop counter
    
    ldr r5,[r0,#(5*4)]      // Load sensitive values
    ldr r4,[r0,#(4*4)]
    ldr r3,[r0,#(3*4)]
    ldr r2,[r0,#(2*4)]
    ldr r1,[r0,#(1*4)]
    ldr r0,[r0,#(0*4)]
    mov r6, #10         // Loop 10 times
    mov r7, #0

    loop_0:
        eor r7, r5
        mov r7, #0
        add r6,#-1      // decrement loop counter
        cmp r6, #0      // Finish the loop?
        bne loop_0      // Branch up
    
    eor r0, r1           // Secret vars 0,1 - .w to not update flags.
    eor r2, r3
    eor r4, r5

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
