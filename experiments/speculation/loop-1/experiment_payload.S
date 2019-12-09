
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    XOR_RR(TMP_0, TMP_0, TMP_0)

    loop_0:

        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

        ADD_RR(TMP_0, TMP_0, ARG_2)

        #if (defined(ARCH_ARMV6M) || defined(ARCH_ARMV7M))

            cmp     TMP_0, ARG_1  // Set compare flags for TMP_0, ARG_1
            bne     loop_0        // Branch if TMP_0(0) != ARG_0

        #elif defined(ARCH_MICROBLAZE)

            cmp     TMP_2, TMP_0, ARG_1
            bnei    TMP_2, loop_0 // Branch if ARG_0 != 0

        #elif defined(ARCH_RV32IMC)

            bne     TMP_0, ARG_1, loop_0

        #else

            // Just exit the loop/experiment immediately.
            .error "Unknown architecture"

        #endif

    // Single NOP between branch and XOR instruction.
    ANOP;
    XOR_RR(TMP_2, TMP_2, ARG_0)

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

