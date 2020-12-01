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

    bri branch_start

target_address:
    NOP_SPACER
    FUNC_RETURN

branch_start:
    NOP_SPACER
    xor r5, r5, r6
    bri  target_address // Always jump. bri
    xor r7, r7, r8
    xor r9, r9, r10

.global experiment_payload_end
experiment_payload_end: nop

