
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ZERO_REG(TMP_2)
    ZERO_REG(TMP_3)

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

#if defined(ARCH_ARMV6M)

    // TMP_0/1 are zero. Hamming distance leakage between ARG_0/1?
    XOR_RR(TMP_0, , ARG_0)
    MOVE(TMP_2,TMP_3)
    XOR_RR(TMP_1, , ARG_1)

#elif defined(ARCH_ARMV7M)

    // TMP_0/1 are zero. Hamming distance leakage between ARG_0/1?
    XOR_RR(TMP_0, , ARG_0)
    MOVE(TMP_2,TMP_3)
    XOR_RR(TMP_1, , ARG_1)

#else
    
    // TMP_0/1 are zero. Hamming distance leakage between ARG_0/1?
    XOR_RR(TMP_0, TMP_0, ARG_0)
    MOVE(TMP_2,TMP_3)
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

