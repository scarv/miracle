#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // eax - d1
                    // edx - d2
    FUNC_ENTER

    // NOT IMPLEMENTED

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

