#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                        // eax = TTest variable 1
    FUNC_ENTER          // edx = loop stop count
                        // ecx = loop increment
    mov $0, %ebx        // ebx = loop counter

    loop_0:

        NOP_SPACER

        add %ecx, %ebx  // Increment loop counter

        cmp %ebx,%edx   // Finish the loop?
        jne loop_0      // Branch up

    eor %eax,%eax       // Operate on secret value.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

