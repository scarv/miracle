
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ADD_RI(STACK,STACK,-16)
    
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    // Expect this to leak
    STORE_WORD_RI(ARG_0, ARG_3, 0)
    STORE_WORD_RI(ARG_1, ARG_3, 0)

    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    
    // Store to stack to clear store path
    STORE_WORD_RI(ARG_2, STACK,4)
    
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    
    // Experiment #1 - Write to stack pack

    // These two stores should not leak 1/2
    STORE_WORD_RI(ARG_2, STACK,4)
    STORE_WORD_RI(ARG_0, ARG_3, 0)

    // These two stores should not leak 2/2
    STORE_WORD_RI(ARG_2, STACK,4)
    STORE_WORD_RI(ARG_1, ARG_3, 0)
    
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    
    // Store to stack to clear store path
    STORE_WORD_RI(ARG_2, STACK,4)
    
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;

    // Experiment #2 - Write to sensitive variable destination.
    
    // These two stores should not leak 1/2
    STORE_WORD_RI(ARG_2, ARG_3, 0)
    STORE_WORD_RI(ARG_0, ARG_3, 0)

    // These two stores should not leak 2/2
    STORE_WORD_RI(ARG_2, ARG_3, 0)
    STORE_WORD_RI(ARG_1, ARG_3, 0)
    
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP; ANOP;
    
    ADD_RI(STACK,STACK, 16)

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

