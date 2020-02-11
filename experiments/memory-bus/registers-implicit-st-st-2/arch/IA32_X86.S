#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax      - uint32_t &din[index1]
                        // edx      - uint32_t &din[index2]
                        // ecx      - TTest variable 1
                        // stack[0] - TTest variable 2 -> ebx
    FUNC_ENTER
    
    // Pop 4'th argument (TTest Variable 2) from stack into ebx
    mov     8(%ebp), %ebx   // Will cause HW leakage on ttest variable 2.

    NOP_SPACER              // May see HD leakage between V1/2 here
    
    mov     %ecx, (%eax)    // write ecx to address in eax (index 1)

    NOP_SPACER
    
    xor     %ecx, %ecx      // Try to clear ALU data path
    
    NOP_SPACER
    
    mov     %ebx, (%edx)    // write ebx to address in edx (index 2)
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:


