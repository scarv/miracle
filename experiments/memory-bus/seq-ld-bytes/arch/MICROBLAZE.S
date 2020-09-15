#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    xor r6 ,r6 ,r6 
    xor r7 ,r7 ,r7 
    xor r8 ,r8 ,r8 
    xor r9 ,r9 ,r9 
    xor r10,r10,r10

    NOP_SPACER

    lbui r6, r5, 2
    lbui r7, r5, 3
    lbui r8, r5, 4
    lbui r9, r5, 5
    lbui r10,r5, 6

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
