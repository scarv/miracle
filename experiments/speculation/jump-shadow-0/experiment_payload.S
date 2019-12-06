
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    
    #if (defined(ARCH_ARMv6) || defined(ARCH_ARMV7M))
    XOR_RR(TMP_0, , ARG_0)
    #else
    XOR_RR(TMP_0, TMP_0 , ARG_0)
    #endif

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    test_0:

        GOTO(test_1)
        #if (defined(ARCH_ARMv6) || defined(ARCH_ARMV7M))
        XOR_RR(TMP_0, , ARG_0)
        #else
        XOR_RR(TMP_0, TMP_0 , ARG_0)
        #endif
    
    test_1:

        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

        GOTO(test_2)
        ANOP;
        #if (defined(ARCH_ARMv6) || defined(ARCH_ARMV7M))
        XOR_RR(TMP_0, , ARG_0)
        #else
        XOR_RR(TMP_0, TMP_0 , ARG_0)
        #endif
    
    test_2:

        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
        
        GOTO(test_3)
        ANOP;
        ANOP;
        #if (defined(ARCH_ARMv6) || defined(ARCH_ARMV7M))
        XOR_RR(TMP_0, , ARG_0)
        #else
        XOR_RR(TMP_0, TMP_0 , ARG_0)
        #endif

    test_3:

        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
        
        GOTO(test_4)
        ANOP;
        ANOP;
        ANOP;
        #if (defined(ARCH_ARMv6) || defined(ARCH_ARMV7M))
        XOR_RR(TMP_0, , ARG_0)
        #else
        XOR_RR(TMP_0, TMP_0 , ARG_0)
        #endif

    test_4:

        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
        ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
        
        GOTO(test_end)
        ANOP;
        ANOP;
        ANOP;
        ANOP;
        #if (defined(ARCH_ARMv6) || defined(ARCH_ARMV7M))
        XOR_RR(TMP_0, , ARG_0)
        #else
        XOR_RR(TMP_0, TMP_0 , ARG_0)
        #endif
    
    test_end:

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

