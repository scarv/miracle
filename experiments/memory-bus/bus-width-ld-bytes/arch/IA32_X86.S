#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax  - zeros
                    // edx  - data to load
    FUNC_ENTER

    NOP_SPACER

    #movb (%eax), %ecx   // Move zeros into ecx
    #
    #NOP_SPACER
    #
    #movb (%edx), %edx   // Load TTest variable.
    #
    #NOP_SPACER
    #
    #movb (%eax), %ecx   // Move zeros into ecx

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
