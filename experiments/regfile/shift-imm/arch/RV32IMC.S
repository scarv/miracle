#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // a0 - TTest variable di1.
                    // a1 - TTest variable di2.
                    // a2 - TTest variable di3.

    FUNC_ENTER

    NOP_SPACER
                        // Access no registers. Shift by ammount corresponding
    slli zero, zero, 11 // to reg a1 number to check implicit access.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
