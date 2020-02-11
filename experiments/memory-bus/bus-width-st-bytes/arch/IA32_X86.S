#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                   
    FUNC_ENTER

    mov $0, %ecx
    mov $0, %ebx

    NOP_SPACER

    movb %cl, (%eax)  // Write zeros through store datapath to zeros array.
                      // Writes a single byte through the datapath
    NOP_SPACER
    
    movb %dl, (%edx)  // Write zeros to TTest array, overwriting TTest var
                      // in memory.
    NOP_SPACER
    
    movb %cl, (%eax)  // Write zeros through datapath again.

    NOP_SPACER

    mov $0, %ecx
    mov $0, %ebx

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

