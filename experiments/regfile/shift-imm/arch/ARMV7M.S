#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r0 - TTest variable di1.
                    // r1 - TTest variable di2.
                    // r2 - TTest variable di3.

    FUNC_ENTER_SHORT
    eor  r3, r3     // clear any pipe registers
    eor  r3, r3     // clear any pipe registers

    NOP_SPACER
    add  r3, r3

    lsr  r3, r3, #0  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #0  // Shift left zero'd r3 by  x. Does this access rx?
    
    lsr  r3, r3, #0  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #1  // Shift left zero'd r3 by  x. Does this access rx?
    
    lsr  r3, r3, #0  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #2  // Shift left zero'd r3 by  x. Does this access rx?
    
    lsr  r3, r3, #1  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #0  // Shift left zero'd r3 by  x. Does this access rx?
    
    lsr  r3, r3, #1  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #1  // Shift left zero'd r3 by  x. Does this access rx?
    
    lsr  r3, r3, #1  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #2  // Shift left zero'd r3 by  x. Does this access rx?
    
    lsr  r3, r3, #2  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #0  // Shift left zero'd r3 by  x. Does this access rx?
    
    lsr  r3, r3, #2  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #1  // Shift left zero'd r3 by  x. Does this access rx?
    
    lsr  r3, r3, #2  // Shift left zero'd r3 by  x. Does this access rx?
    lsr  r3, r3, #2  // Shift left zero'd r3 by  x. Does this access rx?
    
    add  r3, r3
    NOP_SPACER

    eor  r0, r0
    eor  r1, r1
    eor  r2, r2

    FUNC_RETURN_SHORT

.global experiment_payload_end
experiment_payload_end: nop

