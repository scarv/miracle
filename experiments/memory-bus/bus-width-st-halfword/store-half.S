
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    //
    // ARG_0 : uint8_t * zeros
    // ARG_1 : uint8_t * din
    //
    
    FUNC_ENTER

    // ARG_2 contains zero
    XOR_RR(ARG_2,ARG_2,ARG_2)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    // store 0 to zeros[doffset]
    STORE_HALF_RI(ARG_2,ARG_0, 0) 
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    // store 0 to din[doffset]
    STORE_HALF_RI(ARG_2,ARG_1, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    // store 0 to zeros[doffset]
    STORE_HALF_RI(ARG_2,ARG_0, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

