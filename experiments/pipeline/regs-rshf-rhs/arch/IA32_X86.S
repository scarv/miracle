#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax - d1 - TTest var 1
                    // edx - d2 - TTest var 2
    FUNC_ENTER

    mov $0, %ebx    // Clear ebx
    mov $0, %ecx    // Clear ecx

    NOP_SPACER

    xor %ebx, %eax  // TTest Var 1 on RHS of XOR
    shr $31, %edx   // Shift Right TTest Var 2 by 31
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:




