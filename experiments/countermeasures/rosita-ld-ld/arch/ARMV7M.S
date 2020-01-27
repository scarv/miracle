#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    add sp,#-16

    NOP_SPACER          // Variant 1: Unprotected
                        // Expect leakage here
    ldr r4,[r0,#0]      // Load TTest variable 1
    ldr r5,[r1,#0]      // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    push {r2}           // Flush store path
    pop  {r5}           // Flush load path

    NOP_SPACER          // Variant 2: protected, load & store flush
                        // Expect no leakage from here.
    ldr r4,[r0,#0]      // Load TTest variable 1
    push {r2}           // Flush store path
    pop  {r5}           // Flush load path
    ldr r5,[r1,#0]      // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    str r2,[sp,#4]      // Store random variable to stack
    ldr r2,[sp,#4]      // Load back random variable from stack

    NOP_SPACER          // Variant 3: protected, load flush only.
                        // Expect no leakage from here.
    ldr r4,[r0,#0]      // Load TTest variable 1
    ldr r2,[sp,#4]      // Flush load path
    ldr r5,[r1,#0]      // Load TTest variable 2
    
    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    str r2,[sp,#4]      // Store random variable to stack
    ldr r2,[sp,#4]      // Load back random variable from stack

    NOP_SPACER          // Variant 4: protected, store flush only.
                        // Expect no leakage from here.
    ldr r4,[r0,#0]      // Load TTest variable 1
    str r2,[sp,#4]      // Store random variable to stack
    ldr r5,[r1,#0]      // Load TTest variable 2
    
    NOP_SPACER

    add sp,#16

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
