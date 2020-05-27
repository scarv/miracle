#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax - TTest variable 1
                    // edx - random mask
    FUNC_ENTER

    NOP_SPACER

    ror $24, %eax  // Rotate

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

