#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:    // eax - uint8_t * zeros
                       // edx - uint8_t * din
    FUNC_ENTER

    mov $0, %ecx       // Clear registers we will load
    mov $0, %ebx       // and data from memory into

    NOP_SPACER

    movb (%eax), %cl   // Move zeros into ecx
                       // Use 8-bit reg identifier    
    NOP_SPACER
    
    movb (%edx), %dl   // Load TTest variable.
    
    NOP_SPACER
    
    movb (%eax), %cl   // Move zeros into ecx

    NOP_SPACER

    mov $0, %ecx       // Clear registers we trashed
    mov $0, %ebx       //

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
