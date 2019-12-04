
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

#if defined(ARCH_ARMV6M)

    // TMP_0/1 are zero. Hamming distance leakage between ARG_0/1?
    XOR_RR(ARG_0, , TMP_0)
    XOR_RR(ARG_1, , TMP_1)

#elif defined(ARCH_ARMV7M)

    // TMP_0/1 are zero. Hamming distance leakage between ARG_0/1?
    XOR_RR(ARG_0, , TMP_0)
    XOR_RR(ARG_1, , TMP_1)

#else
    
    // TMP_0/1 are zero. Hamming distance leakage between ARG_0/1?
    XOR_RR(TMP_0, TMP_0, ARG_0)
    XOR_RR(TMP_1, TMP_1, ARG_1)

#endif
    
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

