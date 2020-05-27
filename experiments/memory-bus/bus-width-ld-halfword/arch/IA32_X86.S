#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:    // eax - uint16_t * zeros
                       // edx - uint16_t * din
    FUNC_ENTER

    mov $0, %ecx       // Clear registers we will load
    mov $0, %ebx       // and data from memory into

    NOP_SPACER

    mov  (%eax), %cx   // Move zeros into cx
                       // Use 16-bit reg identifier
    NOP_SPACER
    
    mov  (%edx), %dx   // Load TTest variable.
    
    NOP_SPACER
    
    mov  (%eax), %cx   // Move zeros into cx

    NOP_SPACER

    mov $0, %ecx       // Clear registers we trashed
    mov $0, %ebx       //

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

