
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    XOR_RR(TMP_0,TMP_0,TMP_0)
    XOR_RR(TMP_1,TMP_1,TMP_1)
    
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    
    LOAD_WORD_RI(TMP_0,ARG_0, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    // Store zero to idx1, overwriting TTest variable 1
    STORE_WORD_RI(TMP_0,ARG_1, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; XOR_RR(TMP_1,TMP_1,TMP_1);
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    // Load idx2
    LOAD_WORD_RI(ARG_2,ARG_2, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    
    LOAD_WORD_RI(TMP_0,ARG_0, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

