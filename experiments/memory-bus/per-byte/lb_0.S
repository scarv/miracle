
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    // Clear arg2/3 so we don't get weird hamming distance from
    // between calls to experiment_payload
    XOR_RR(ARG_2,ARG_2,ARG_2)
    XOR_RR(ARG_3,ARG_3,ARG_3)

    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(ARG_3,ARG_0,0)    // Load from Flash
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(TMP_0,ARG_0,1)    // Load from Flash
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(TMP_1,ARG_0,2)    // Load from Flash
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(TMP_2,ARG_0,3)    // Load from Flash
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(TMP_3,ARG_0,4)    // Load from Flash
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP

    XOR_RR(ARG_3,ARG_3,ARG_3)
    XOR_RR(TMP_0,TMP_0,TMP_0)
    XOR_RR(TMP_1,TMP_1,TMP_1)
    XOR_RR(TMP_2,TMP_2,TMP_2)
    XOR_RR(TMP_3,TMP_3,TMP_3)
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(ARG_3,ARG_1,0)    // Load from SRAM
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(TMP_0,ARG_1,1)    // Load from SRAM
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(TMP_1,ARG_1,2)    // Load from SRAM
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(TMP_2,ARG_1,3)    // Load from SRAM
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    LOAD_UBYTE_RI(TMP_3,ARG_1,4)    // Load from SRAM
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    ANOP ; ANOP ; ANOP
    
    XOR_RR(ARG_3,ARG_3,ARG_3)
    XOR_RR(TMP_0,TMP_0,TMP_0)
    XOR_RR(TMP_1,TMP_1,TMP_1)
    XOR_RR(TMP_2,TMP_2,TMP_2)
    XOR_RR(TMP_3,TMP_3,TMP_3)
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

