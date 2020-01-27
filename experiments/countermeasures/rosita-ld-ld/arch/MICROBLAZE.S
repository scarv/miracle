#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi r1,r1,-16

    NOP_SPACER          // Variant 1: unprotected
                        // Expect leakage here
    lwi r9,r5,0         // Load TTest variable 1
    lwi r10,r6,0        // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
    and r7,r7,r7        // Flush data load / store path
    swi r7,r1,4         // Store random variable to stack
    lwi r7,r1,4         // Load random variable from stack

    NOP_SPACER          // Variant 2: protected, load & store flush
                        // Expect no leakage here
    lwi r9,r5,0         // Load TTest variable 1
    swi r7,r1,4         // Store random variable to stack
    lwi r7,r1,4         // Load random variable from stack
    lwi r10,r6,0        // Load TTest variable 2
    
    NOP_SPACER          // Barrier between variants. ------------------------
    and r7,r7,r7        // Flush data load / store path
    swi r7,r1,4         // Store random variable to stack
    lwi r7,r1,4         // Load random variable from stack

    NOP_SPACER          // Variant 3: protected, load flush only
    and r7,r7,r7        // Flush data load / store path
    lwi r9,r5,0         // Load TTest variable 1
    lwi r7,r1,4         // Load random variable from stack
    lwi r10,r6,0        // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
    and r7,r7,r7        // Flush data load / store path
    swi r7,r1,4         // Store random variable to stack
    lwi r7,r1,4         // Load random variable from stack

    NOP_SPACER          // Variant 4: protected, store flush only
                        // Expect no leakage here
    lwi r9,r5,0         // Load TTest variable 1
    swi r7,r1,4         // Store random variable to stack
    lwi r10,r6,0        // Load TTest variable 2

    NOP_SPACER

    addi r1,r1,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
