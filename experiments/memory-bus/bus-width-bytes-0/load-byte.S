
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ANOP; ANOP; ANOP; ANOP;
    LOAD_UBYTE_RI(ARG_1,ARG_0,0) ; XOR_RR(ARG_1,ARG_1,ARG_1)
    ANOP; ANOP; ANOP; ANOP;
    LOAD_UBYTE_RI(ARG_1,ARG_0,1) ; XOR_RR(ARG_1,ARG_1,ARG_1)
    ANOP; ANOP; ANOP; ANOP;
    LOAD_UBYTE_RI(ARG_1,ARG_0,2) ; XOR_RR(ARG_1,ARG_1,ARG_1)
    ANOP; ANOP; ANOP; ANOP;
    LOAD_UBYTE_RI(ARG_1,ARG_0,3) ; XOR_RR(ARG_1,ARG_1,ARG_1)
    ANOP; ANOP; ANOP; ANOP;
    LOAD_UBYTE_RI(ARG_1,ARG_0,4) ; XOR_RR(ARG_1,ARG_1,ARG_1)
    ANOP; ANOP; ANOP; ANOP;
    LOAD_UBYTE_RI(ARG_1,ARG_0,5) ; XOR_RR(ARG_1,ARG_1,ARG_1)
    ANOP; ANOP; ANOP; ANOP;
    LOAD_UBYTE_RI(ARG_1,ARG_0,6) ; XOR_RR(ARG_1,ARG_1,ARG_1)
    ANOP; ANOP; ANOP; ANOP;
    LOAD_UBYTE_RI(ARG_1,ARG_0,7) ; XOR_RR(ARG_1,ARG_1,ARG_1)
    ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

