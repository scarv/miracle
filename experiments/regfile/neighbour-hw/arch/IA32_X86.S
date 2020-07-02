#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax - varialbe d1
                    // ecx - variable d2.
    FUNC_ENTER      // edx - variable d3.
    
    xor %ecx, %ecx  // Clear ecx
    xor %edx, %edx  // Clear edx

    NOP_SPACER

    mov %edx, %edx
    mov %ecx, %ecx

    NOP_SPACER

    mov %ecx, %ecx
    mov %edx, %edx

    NOP_SPACER

    mov %edx, %ecx
    mov %ecx, %edx

    NOP_SPACER

    mov %ecx, %edx
    mov %edx, %ecx
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop



