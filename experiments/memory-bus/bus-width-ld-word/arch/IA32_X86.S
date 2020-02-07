#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                   
    FUNC_ENTER

    NOP_SPACER

    movl (%eax), %ecx   // Move zeros into ecx
    
    NOP_SPACER
    
    movl (%edx), %edx   // Load TTest variable.
    
    NOP_SPACER
    
    movl (%eax), %ecx   // Move zeros into ecx

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:


