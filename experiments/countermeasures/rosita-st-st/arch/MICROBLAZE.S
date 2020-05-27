#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi r1,r1,-16

    NOP_SPACER      // Variant 1, expect leakage
                                                                  
    swi r5,r8,0     // Store TTest variable 1
    and r7,r7,r7    // Flush ALU datapath as much as possible.
    swi r6,r8,0     // Store TTest variable 2
                                                                  
    NOP_SPACER      // Barrier
    swi r7,r1,4     // Flush store datapath
                                                                  
    NOP_SPACER      // Variant 2, overwrite stack countermeasure
                                                                  
    swi r7,r1,4     // Store random variable to stack
    swi r5,r8,0     // Store TTest variable 1 to location X
    and r7,r7,r7    // Flush ALU datapath as much as possible.
    swi r7,r1,4     // Store random variable to stack
    swi r6,r8,0     // Store TTest variable 2 to locaton X
                                                                  
    NOP_SPACER      // Barrier
    swi r7,r1,4     // Flush store datapath
                                                                  
    NOP_SPACER      // Variant 3, overwrite destination address X
                                                                  
    swi r7,r8,0     // Store random variable to location X
    swi r5,r8,0     // Store TTest variable 1 to location X
    and r7,r7,r7    // Flush ALU datapath as much as possible.
    swi r7,r8,0     // Store random variable to locaton X
    swi r6,r8,0     // Store TTest variable 2 to location X

    NOP_SPACER

    addi r1,r1,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
