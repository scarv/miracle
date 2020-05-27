#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
                        // eax = TTest variable 1
    FUNC_ENTER          // edx = TTest variable 2
                        // ecx = Branch or not?

    NOP_SPACER

    cmp $0, %cl         // Should we branch?
    jne branch_target
    je  branch_target

    mov %eax,%eax           // Manipulate secret variable 0
    mov %edx,%edx           // Manipulate secret variable 1

    NOP_SPACER

    branch_target:

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

