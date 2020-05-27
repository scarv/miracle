#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax - TTest Var 1
                        // edx - TTest Var 2
    FUNC_ENTER          // ecx - Random value
                        //
    mov     4(%ebp), %ebx  // ebx - Destination address

    NOP_SPACER          // Variant 1, expect leakage

    mov %eax, (%ebx)    // Store TTest variable 1
    and %ecx, %ecx      // Flush ALU datapath as much as possible.
    mov %edx, (%ebx)    // Store TTest variable 2

    NOP_SPACER          // Barrier
    push %ecx           // Flush Store datapath by pushing random value
    pop  %ecx           // Load back random variable from stack

    NOP_SPACER          // Variant 2, overwrite stack countermeasure

    mov %ecx,-4(%esp)   // Store random variable to stack
    mov %eax, (%ebx)    // Store TTest variable 1
    and %ecx, %ecx      // Flush ALU datapath as much as possible.
    mov %ecx,-4(%esp)   // Store random variable to stack
    mov %edx, (%ebx)    // Store TTest variable 2
    
    NOP_SPACER          // Barrier
    push %ecx           // Flush Store datapath by pushing random value
    pop  %ecx           // Load back random variable from stack

    NOP_SPACER          // Variant 3, overwrite destination address X

    mov %ecx, (%ebx)    // Store random variable to location X
    mov %eax, (%ebx)    // Store TTest variable 1
    and %ecx, %ecx      // Flush ALU datapath as much as possible.
    mov %ecx, (%ebx)    // Store random variable to location X
    mov %edx, (%ebx)    // Store TTest variable 2
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end: nop

