#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // a0 - TTest variable di1.
                    // a1 - TTest variable di2.
                    // a2 - TTest variable di3.

    FUNC_ENTER

    NOP_SPACER
                        // Access no registers. Shift by ammount corresponding
    slli zero, zero, 11 // to reg a1 number to check implicit access.
    slli zero, zero, 11 // to reg a1 number to check implicit access.
    
    slli zero, zero, 11 // to reg a1 number to check implicit access.
    slli zero, zero, 12 // to reg a1 number to check implicit access.
    
    slli zero, zero, 11 // to reg a1 number to check implicit access.
    slli zero, zero, 13 // to reg a1 number to check implicit access.
    
    slli zero, zero, 12 // to reg a1 number to check implicit access.
    slli zero, zero, 11 // to reg a1 number to check implicit access.
    
    slli zero, zero, 12 // to reg a1 number to check implicit access.
    slli zero, zero, 12 // to reg a1 number to check implicit access.
    
    slli zero, zero, 12 // to reg a1 number to check implicit access.
    slli zero, zero, 13 // to reg a1 number to check implicit access.
    
    slli zero, zero, 13 // to reg a1 number to check implicit access.
    slli zero, zero, 11 // to reg a1 number to check implicit access.
    
    slli zero, zero, 13 // to reg a1 number to check implicit access.
    slli zero, zero, 12 // to reg a1 number to check implicit access.
    
    slli zero, zero, 13 // to reg a1 number to check implicit access.
    slli zero, zero, 13 // to reg a1 number to check implicit access.

    NOP_SPACER

    xor  a0, a0, a0
    xor  a1, a1, a1
    xor  a2, a2, a2

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
