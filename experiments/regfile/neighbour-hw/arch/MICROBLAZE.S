#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    ori r7, r5, 0       // Move r5 / arg0 to r7
    xor r5, r5, r5      // Clear r5
    xor r6, r6, r6      // Clear r6
    xor r8, r8, r8      // Clear r8

    NOP_SPACER

    ori r4, r4, 0   // Skip over accessing r7
    ori r5, r5, 0   //

    NOP_SPACER
    
    ori r5, r5, 0   // Skip over accessing r7
    ori r8, r8, 0   //

    NOP_SPACER
    
    ori r8, r8, 0   // Skip over accessing r7
    ori r4, r4, 0   //

    NOP_SPACER
    
    ori r6, r6, 0   // Skip over accessing r7
    ori r5, r5, 0   //
    
    NOP_SPACER
    
    ori r6, r6, 0   // Skip over accessing r7
    ori r7, r7, 0   //

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
