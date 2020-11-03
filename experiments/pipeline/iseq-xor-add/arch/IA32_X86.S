#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax - di1
                    // edx - di2
                    // ecx - di3

    FUNC_ENTER

    NOP_SPACER

    eor %edx, %eax
    eor %ecx, %edx
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

