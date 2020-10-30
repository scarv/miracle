#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    NOP_SPACER

    sbi r6, r5, 0
    sbi r7, r5, 1
    sbi r8, r5, 2
    sbi r6, r5, 3
    sbi r7, r5, 4
    sbi r8, r5, 5

    NOP_SPACER

    xor r6, r6, r6
    xor r7, r7, r7
    xor r8, r8, r8

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
