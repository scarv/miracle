#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax - TTest Var 1
                        // edx - TTest Var 2
    FUNC_ENTER          // ecx - Random value
                        //
    mov     4(%ebp), %ebx  // ebx - Destination address

    NOP_SPACER          // Variant 1, expect leakage

    mov %eax, (%ebx)    // Store TTest variable 1
    and %ecx, %ecx      // Flush ALU datapath as much as possible.
    mov %edx, 4(%ebx)    // Store TTest variable 2

    NOP_SPACER          // Barrier

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

