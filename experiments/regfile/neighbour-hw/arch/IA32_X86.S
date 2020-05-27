#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax - d1 - TTest var 1

    FUNC_ENTER
    
    mov %eax, %ebx  // Move eax to ebx
    xor %eax, %eax  // Clear eax
    xor %ecx, %ecx  // Clear ecx
    xor %edx, %edx  // Clear edx

    NOP_SPACER

    mov %eax, %eax
    mov %ecx, %ecx

    NOP_SPACER

    mov %eax, %eax
    mov %edx, %edx

    NOP_SPACER

    mov %edx, %edx
    mov %ecx, %ecx

    NOP_SPACER

    mov %edx, %edx
    mov %eax, %eax
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop



