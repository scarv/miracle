#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax = TTest variable 1
                        // edx = TTest variable 2
    FUNC_ENTER          // ecx = Random value.


    NOP_SPACER          // Variant 1: Unprotected
                        // Expect leakage here
    mov (%eax),%eax     // Load TTest variable 1
    mov (%edx),%edx     // Load TTest variable 2

    NOP_SPACER          //

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

