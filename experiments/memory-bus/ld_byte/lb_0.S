
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    // Clear arg2/3 so we don't get weird hamming distance from
    // between calls to experiment_payload
    XOR_RR(ARG_2,ARG_2,ARG_2)
    XOR_RR(ARG_3,ARG_3,ARG_3)

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
    ANOP
    ANOP
    ANOP

    // Load from Flash
    LOAD_UBYTE_RI(ARG_2,ARG_0,0)
    

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
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    
    // Load from SRAM
    LOAD_UBYTE_RI(ARG_3,ARG_1,0)
    
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
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP

    // Clear the registers we used ready for next iteration.
    XOR_RR(ARG_2,ARG_2,ARG_2)
    XOR_RR(ARG_3,ARG_3,ARG_3)

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

