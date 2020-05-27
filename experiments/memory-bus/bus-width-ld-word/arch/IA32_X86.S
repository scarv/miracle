#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax - uint32_t * zeros
                        // edx - uint32_t * din
    FUNC_ENTER

    mov $0, %ecx        // Clear registers we will load
    mov $0, %ebx        // and data from memory into

    NOP_SPACER

    movl (%eax), %ecx   // Move zeros into ecx
                        // Use word reg identifier
    NOP_SPACER
    
    movl (%edx), %ebx   // Load TTest variable.
    
    NOP_SPACER
    
    movl (%eax), %ecx   // Move zeros into ecx

    NOP_SPACER

    mov $0, %ecx        // Clear registers we trashed
    mov $0, %ebx        //

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop


