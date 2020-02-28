#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax = TTest variable 1
                        // edx = TTest variable 2
    FUNC_ENTER          // ecx = Random value.

    NOP_SPACER          // Variant 4: protected, store flush only.
                        // Expect no leakage from here.
    mov (%eax),%eax     // Load TTest variable 1
    mov %ecx, -8(%ebp)  // Flush load path
    mov (%edx),%edx     // Load TTest variable 2

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

