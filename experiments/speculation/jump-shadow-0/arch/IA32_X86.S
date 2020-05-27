#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax - TTest Var 0
                        // edx - TTest Var 1
    FUNC_ENTER          // ecx - TTest Var 2
                        //
    mov     4(%ebp), %ebx  // ebx - TTest Var 3

    NOP_SPACER          // 
                        // 
    xor %eax,%eax       // Clear secret value 0 to get a
                        // Baseline for how things leak.
    NOP_SPACER

    test_0:
        jmp test_end    // Branch to test_enc
        xor %edx,%edx   // Clear secret value R1
        xor %ecx,%ecx   // Clear secret value R2
        xor %ebx,%ebx   // Clear secret value R3

    test_end:

        NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

