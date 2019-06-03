
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER
    
    // Clear the destination registers
    XOR_RR(ARG_2,ARG_2,ARG_2)
    XOR_RR(ARG_3,ARG_3,ARG_3)
    XOR_RR(TMP_0,TMP_0,TMP_0)
    XOR_RR(TMP_1,TMP_1,TMP_1)

    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    ANOP
    
    LOAD_WORD_RI(ARG_3,ARG_0,12)     // Load a fixed/random word into arg reg 3
    
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    
    LOAD_WORD_RI(TMP_0,ARG_0,0)     // Load the "key" into arg reg 2

    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    
    LOAD_WORD_RI(ARG_3,ARG_0,12)    // Load a fixed/random word into arg reg 3
    
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 

    // Clear the registers we used ready for next iteration.
    XOR_RR(ARG_2,ARG_2,ARG_2)
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 

    XOR_RR(ARG_3,ARG_3,ARG_3)
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    XOR_RR(TMP_0,TMP_0,TMP_0)
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    ANOP; ANOP; ANOP; 
    XOR_RR(TMP_1,TMP_1,TMP_1)

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

