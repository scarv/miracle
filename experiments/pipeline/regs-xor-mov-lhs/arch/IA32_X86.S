#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax - d1
                    // edx - d2
    FUNC_ENTER

    mov $0, %ebx    // Clear ebx
    mov $0, %ecx    // Clear ecx

    NOP_SPACER

    xor %eax, %ebx  // Secret values on LHS of XOR
    mov %ecx, %ecx  // MOV Barrier
    xor %edx, %ecx  // Secret values on LHS of XOR
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

