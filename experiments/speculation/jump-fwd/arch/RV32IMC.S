#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER          // a0 - TTest variable di1
                        // a1 - TTest variable di2
    NOP_SPACER          // a2 - TTest variable di3
                        // a3 - TTest variable di4
    
    j   target_address
    add a0, a0, a0
    add a1, a1, a1
    add a2, a2, a2
    add a3, a3, a3

target_address:
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

