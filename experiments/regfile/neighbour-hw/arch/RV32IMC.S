#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    mv  a1, a0          // Move a0 to a1
    xor a0, a0, a0      // Clear r0
    xor a2, a2, a2      // Clear r2
    xor a3, a3, a3      // Clear r3

    NOP_SPACER

    mv  a0, a0      // Skip over accessing a1
    mv  a3, a3      //

    NOP_SPACER
    
    mv  a3, a3      // Skip over accessing a1
    mv  a2, a2      //

    NOP_SPACER
    
    mv  a0, a0      // Skip over accessing a1
    mv  a2, a2      //

    NOP_SPACER
    
    mv  a3, a3      // Skip over accessing a1
    mv  a0, a0      //
    

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
