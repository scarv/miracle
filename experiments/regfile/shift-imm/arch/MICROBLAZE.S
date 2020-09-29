#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r5 - TTest variable di1.
                    // r6 - TTest variable di2.
                    // r7 - TTest variable di3.

    FUNC_ENTER

    NOP_SPACER
                      // Access no registers. Shift by ammount corresponding
    bslli   r0, r0, 5 // to reg r6 number to check implicit access.
    bslli   r0, r0, 5 // to reg r6 number to check implicit access.
    
    bslli   r0, r0, 5 // to reg r6 number to check implicit access.
    bslli   r0, r0, 6 // to reg r6 number to check implicit access.
    
    bslli   r0, r0, 5 // to reg r6 number to check implicit access.
    bslli   r0, r0, 7 // to reg r6 number to check implicit access.
    
    bslli   r0, r0, 6 // to reg r6 number to check implicit access.
    bslli   r0, r0, 5 // to reg r6 number to check implicit access.
    
    bslli   r0, r0, 6 // to reg r6 number to check implicit access.
    bslli   r0, r0, 6 // to reg r6 number to check implicit access.
    
    bslli   r0, r0, 6 // to reg r6 number to check implicit access.
    bslli   r0, r0, 7 // to reg r6 number to check implicit access.
    
    bslli   r0, r0, 7 // to reg r6 number to check implicit access.
    bslli   r0, r0, 5 // to reg r6 number to check implicit access.
    
    bslli   r0, r0, 7 // to reg r6 number to check implicit access.
    bslli   r0, r0, 6 // to reg r6 number to check implicit access.
    
    bslli   r0, r0, 7 // to reg r6 number to check implicit access.
    bslli   r0, r0, 7 // to reg r6 number to check implicit access.

    NOP_SPACER
    
    xor  r5, r5, r5
    xor  r6, r6, r6
    xor  r7, r7, r7

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
