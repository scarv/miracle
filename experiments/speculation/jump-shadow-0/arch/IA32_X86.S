#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax - TTest Var di0
                        // edx - TTest Var di1
    FUNC_ENTER          // ecx - TTest Var di2

    NOP_SPACER

    test_0:
        jmp test_end    // Branch to test_end - jump over secret clearing
        xor %eax,%eax   // Clear secret value 0
        xor %edx,%edx   // Clear secret value 1
        xor %ecx,%ecx   // Clear secret value 2

        NOP_SPACER

    test_end:

        NOP_SPACER
        
        xor %eax,%eax   // Clear secret value 0
        xor %edx,%edx   // Clear secret value 1
        xor %ecx,%ecx   // Clear secret value 2

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

