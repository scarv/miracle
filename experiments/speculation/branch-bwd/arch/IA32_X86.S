#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax - TTest Var di0
                        // edx - TTest Var di1
    FUNC_ENTER          // ecx - TTest Var di2

    // NOT IMPLEMENTED TODO

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

