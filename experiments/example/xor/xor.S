
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP

    XOR_RR(ARG_2,ARG_0,ARG_1) // note: xor is destructive on ARMv6

    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

