#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // a0 - ttest variable.

    FUNC_ENTER

    NOP_SPACER
                        // Access no registers. Shift by ammount corresponding
    slli zero, zero, 10 // to reg a0 number to check implicit access.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
