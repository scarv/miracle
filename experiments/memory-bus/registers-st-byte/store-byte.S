
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    
    STORE_BYTE_RI(ARG_1,ARG_0, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    STORE_BYTE_RI(ARG_2,ARG_1, 0)

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

