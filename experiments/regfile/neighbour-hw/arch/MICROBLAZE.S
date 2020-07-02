#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // r5 - variable d1
                        // r6 - variable d2
    FUNC_ENTER          // r7 - variable d3
                        // r8 - variable d4

    xor     r9 , r9 , r9 
    xor     r10, r10, r10
    xor     r11, r11, r11
    xor     r12, r12, r12

    NOP_SPACER
    NOP_SPACER

    xor     r9 , r9 , r9 
    xor     r10, r10, r10
    xor     r11, r11, r11
    xor     r12, r12, r12
    xor     r9 , r9 , r10
    xor     r10, r10, r11
    xor     r11, r11, r12
    xor     r12, r12, r9
    xor     r9 , r9 , r11
    xor     r10, r10, r12
    xor     r11, r11, r9 
    xor     r12, r12, r10

    NOP_SPACER
    NOP_SPACER

    xor     r5 , r5 , r5
    xor     r6 , r6 , r6
    xor     r7 , r7 , r7
    xor     r8 , r8 , r8

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
