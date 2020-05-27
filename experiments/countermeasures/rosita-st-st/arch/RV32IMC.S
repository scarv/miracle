#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    addi sp,sp,-16

    NOP_SPACER          // Variant 1, expect leakage
                                                                      
    sw a0,0(a3)         // Store TTest variable 1
    and a2,a2,a2        // Flush ALU datapath as much as possible.
    sw a1,0(a3)         // Store TTest variable 2
                                                                      
    NOP_SPACER          // Barrier
    sw a2,4(sp)         // Flush store datapath
                                                                      
    NOP_SPACER          // Variant 2, overwrite stack countermeasure
                                                                      
    sw a2,4(sp)         // Store random variable to stack
    sw a0,0(a3)         // Store TTest variable 1 to location X
    and a2,a2,a2        // Flush ALU datapath as much as possible.
    sw a2,4(sp)         // Store random variable to stack
    sw a1,0(a3)         // Store TTest variable 2 to locaton X
                                                                      
    NOP_SPACER          // Barrier
    sw a2,4(sp)         // Flush store datapath
                                                                      
    NOP_SPACER          // Variant 3, overwrite destination address X
                                                                      
    sw a2,0(a3)         // Store random variable to location X
    sw a0,0(a3)         // Store TTest variable 1 to location X
    and a2,a2,a2        // Flush ALU datapath as much as possible.
    sw a2,0(a3)         // Store random variable to locaton X
    sw a1,0(a3)         // Store TTest variable 2 to location X

    NOP_SPACER

    addi sp,sp,16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop
