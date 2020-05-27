#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                        // eax = TTest variable 1
    FUNC_ENTER          // edx = loop stop count
                        // ecx = loop increment
    mov     4(%ebp), %ebx  // ebx - TTest Var 2

    loop_0:

        NOP_SPACER

        sub %ecx, %edx  // Decrement loop counter

        cmp $0, %edx    // Finish the loop?
        jne loop_0      // Branch up

    mov %eax,%eax       // Operate on TTest variable 1.
    mov %ebx,%ebx       // Operate on TTest variable 2.

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop


