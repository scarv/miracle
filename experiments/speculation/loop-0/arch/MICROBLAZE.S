#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                                // r5 = sensitive value array
    FUNC_ENTER                  // r11= loop count er

    lwi r10, r5, 5*4
    lwi r9 , r5, 4*4
    lwi r8 , r5, 3*4
    lwi r7 , r5, 2*4
    lwi r6 , r5, 1*4
    lwi r5 , r5, 0*4
    addi  r11, r0, 10           // loop 10 times.
    add  r12, r0, r0

    loop_0:                                                
        xor r12, r12, r10
        add  r12, r0, r0
        addi r11, r11, -1                                                  
        bnei r11, loop_0    // Branch up
                                                           
    xor r5, r5, r6
    xor r7, r7, r8
    xor r9, r9, r10

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
