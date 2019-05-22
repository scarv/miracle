
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    // Clear arg1 so we don't get weird hamming distance from
    // between calls to experiment_payload
    XOR_RR(ARG_1,ARG_1,ARG_1)

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

    LOAD_UBYTE_RI(ARG_1,ARG_0,0)
    
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

    // Clear the registers we used ready for next iteration.
    XOR_RR(ARG_1,ARG_1,ARG_1)
    XOR_RR(ARG_0,ARG_0,ARG_0)

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

