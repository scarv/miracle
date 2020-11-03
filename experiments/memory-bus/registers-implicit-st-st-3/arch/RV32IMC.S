#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    NOP_SPACER

    sw a2,0(a0)     // Store TTest var 1 to idx 1
    sw x0,0(a1)     // Try to flush ALU datapath
    sw a3,0(a0)     // Store TTest var 2 to idx 2

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
