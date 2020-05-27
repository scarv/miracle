#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:   // r5 - ttest variable.

    FUNC_ENTER

    NOP_SPACER
                      // Access no registers. Shift by ammount corresponding
    bslli   r0, r0, 5 // to reg r5 number to check implicit access.

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
