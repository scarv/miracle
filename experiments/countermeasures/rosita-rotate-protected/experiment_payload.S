
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

#if defined(ARCH_ARMV6M)

    mov     ARG_2, #24
    
    eor     ARG_0, ARG_1        // Mask thing being rotated.
    ror     ARG_0, ARG_2
    ror     ARG_1, ARG_2
    eor     ARG_0, ARG_1        // Unmask thing being rotated.

#elif defined(ARCH_ARMV7M)
    
    mov     ARG_2, #24
    
    eor     ARG_0, ARG_1        // Mask thing being rotated.
    ror     ARG_0, ARG_2
    ror     ARG_1, ARG_2
    eor     ARG_0, ARG_1        // Unmask thing being rotated.

#elif defined(ARCH_MICROBLAZE)

    xor     ARG_0, ARG_0, ARG_1 // Mask thing being rotated.

    bsrli   ARG_0, ARG_2, 24
    bslli   TMP_1, ARG_2, 8
    or      ARG_0, ARG_0, TMP_1
    
    xor     ARG_0, ARG_0, ARG_1 // Unmask thing being rotated.

#elif defined(ARCH_RV32IMC)
    
    xor     ARG_0, ARG_0, ARG_1 // Mask thing being rotated.

    srli    ARG_0, ARG_2, 24
    slli    TMP_1, ARG_2, 8
    or      ARG_0, ARG_0, TMP_1
    
    xor     ARG_0, ARG_0, ARG_1 // Unmask thing being rotated.

#else
    
    #error Unknown architecture for rosita-rotate-1

#endif
    
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

