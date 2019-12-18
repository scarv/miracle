
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

    ror     ARG_0, ARG_2

#elif defined(ARCH_ARMV7M)
    
    mov     ARG_2, #24

    ror     ARG_0, ARG_2

#elif defined(ARCH_MICROBLAZE)

    bsrli   ARG_0, ARG_2, 24
    bslli   TMP_1, ARG_2, 8
    or      ARG_0, ARG_0, TMP_1

#elif defined(ARCH_RV32IMC)

    srli    ARG_0, ARG_2, 24
    slli    TMP_1, ARG_2, 8
    or      ARG_0, ARG_0, TMP_1

#else
    
    #error Unknown architecture for rosita-rotate-1

#endif
    
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

