
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER
    
    XOR_RR(TMP_0, TMP_0, TMP_0); // Make sure TMP_0 is zero.

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    #if (defined(ARCH_ARMV6M) || defined(ARCH_ARMV7M))

        cmp     TMP_0, ARG_2        // Set compare flags for TMP_0, ARG_2
        bne     branch_target       // Branch if ARG_2 != zero
        beq     branch_target       // Branch if ARG_2 == zero

    #elif defined(ARCH_MICROBLAZE)

        cmp     TMP_2, TMP_0, ARG_2
        bnei    TMP_2, branch_target // Branch if ARG_2 != 0
        beqi    TMP_2, branch_target // Branch if ARG_2 == 0

    #elif defined(ARCH_RV32IMC)

        bnez    ARG_2, branch_target // Branch if ARG_2 != 0
        beqz    ARG_2, branch_target // Branch if ARG_2 == 0

    #else

        // Just exit the loop/experiment immediately.
        .error "Unknown architecture"

    #endif
    

    //
    // Secret / leaking operation - XOR two arguments together.

    #if (defined(ARCH_ARMv6) || defined(ARCH_ARMV7M))
        
        XOR_RR(ARG_1, , ARG_0)

    #else
        
        XOR_RR(TMP_0, ARG_1 , ARG_0)

    #endif

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    branch_target:

        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:


