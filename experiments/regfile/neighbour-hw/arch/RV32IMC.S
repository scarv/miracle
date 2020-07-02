#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // a0 - variable d1
                        // a1 - variable d2
    FUNC_ENTER          // a2 - variable d3
                        // a3 - variable d4

    xor     a4, a4, a4 
    xor     a5, a5, a5
    xor     a6, a6, a6
    xor     a7, a7, a7

    NOP_SPACER
    NOP_SPACER

    xor     a4, a4, a4 
    xor     a5, a5, a5
    xor     a6, a6, a6
    xor     a7, a7, a7
    xor     a4, a4, a5
    xor     a5, a5, a6
    xor     a6, a6, a7
    xor     a7, a7, a4
    xor     a4, a4, a6
    xor     a5, a5, a7
    xor     a6, a6, a4
    xor     a7, a7, a5

    NOP_SPACER
    NOP_SPACER

    xor     a0, a0, a0 
    xor     a1, a1, a1
    xor     a2, a2, a2
    xor     a3, a3, a3

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
