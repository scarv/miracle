
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    XOR_RR(TMP_0,TMP_0,TMP_0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    
    // Clear the store path as best we can by writing zero
    // to the data in array locations.
    STORE_WORD_RI(TMP_0,ARG_0, 0)
    STORE_WORD_RI(TMP_0,ARG_1, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    // Store TTest variable 1 to din+index1
    STORE_WORD_RI(ARG_2,ARG_0, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; XOR_RR(TMP_1,TMP_1,TMP_1);
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    // Store TTest variable 2 to din+index2
    STORE_WORD_RI(ARG_3,ARG_1, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    
    // Clear the store path as best we can by writing zero
    // to the data in array locations.
    STORE_WORD_RI(TMP_0,ARG_0, 0)
    STORE_WORD_RI(TMP_0,ARG_1, 0)

    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

