#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax - d1
                    // edx - d2
    FUNC_ENTER

    mov $0, %ebx    // Clear ebx
    mov $0, %ecx    // Clear ecx

    NOP_SPACER

    xor %ebx, %eax  // Secret values on RHS of XOR
    nop
    xor %ecx, %edx  // Secret values on RHS of XOR
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop



