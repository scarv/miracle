#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax - zeros array
                        // edx - ttest array 1
                        // ecx - ttest array 2
    FUNC_ENTER
    
    mov $0, %ebx        // and data from memory into

    NOP_SPACER

    mov  (%eax), %ebx   // Move zeros into ebx
                        // Use 32-bit reg identifier
    NOP_SPACER
    
    mov  (%edx), %edx   // Load TTest variable 1
    
    NOP_SPACER
    
    mov  (%ecx), %ecx   // Load TTest variable 2

    NOP_SPACER
    
    mov  (%eax), %ebx   // Move zeros into ebx
    
    NOP_SPACER
    
    mov $0, %ebx        // Clear registers we trashed
    mov $0, %ecx        // 
    mov $0, %edx        // 

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:


