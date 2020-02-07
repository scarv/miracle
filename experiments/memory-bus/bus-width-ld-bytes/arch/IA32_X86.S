#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                   
    FUNC_ENTER

    //movl 4(%esp),%eax   // eax = uint8 * zeros
    //movl 8(%esp),%edx   // edx = uint8 * data

    NOP_SPACER

    movb (%eax), %ecx   // Move zeros into ecx
    
    NOP_SPACER
    
    movb (%edx), %edx   // Load TTest variable.
    
    NOP_SPACER
    
    movb (%eax), %ecx   // Move zeros into ecx

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
