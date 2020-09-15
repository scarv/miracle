#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:    // eax - uint8_t * zeros
                       // edx - uint8_t * din
    FUNC_ENTER

    // NOT IMPLEMENTED TODO

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
