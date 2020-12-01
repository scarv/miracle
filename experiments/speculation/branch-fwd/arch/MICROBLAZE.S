#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:         // r5 - pointer to d1..d6 array

    FUNC_ENTER

    lwi r10, r5, 5*4        // Load sensitive values
    lwi r9 , r5, 4*4
    lwi r8 , r5, 3*4
    lwi r7 , r5, 2*4
    lwi r6 , r5, 1*4
    lwi r5 , r5, 0*4
    
    xor r11, r11, r11       // Clear register 11
    xor r11, r11, r11

branch_start:
    NOP_SPACER
    xor r5, r5, r6
    beqi r0, target_address // Always jump. beqi - branch if r0=0
    xor r7, r7, r8
    xor r9, r9, r10

target_address:
    NOP_SPACER
    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

