
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER
    
    // Clear the destination registers
    XOR_RR(ARG_2,ARG_2,ARG_2)
    XOR_RR(ARG_3,ARG_3,ARG_3)

    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP

    LOAD_WORD_RI(ARG_2,ARG_0,0)     // Load the "key" into arg reg 2
    
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    
    LOAD_WORD_RI(ARG_3,ARG_0,8)     // Load a random word into arg reg 3

    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    
    LOAD_WORD_RI(ARG_3,ARG_0,12)    // Load another random word into arg reg 2

    // Clear the registers we used ready for next iteration.
    XOR_RR(ARG_2,ARG_2,ARG_2)
    XOR_RR(ARG_3,ARG_3,ARG_3)

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

