#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:     // eax = TTest variable 1
                        // edx = TTest variable 2
    FUNC_ENTER          // ecx = Random value.


    NOP_SPACER          // Variant 1: Unprotected
                        // Expect leakage here
    mov (%eax),%eax     // Load TTest variable 1
    mov (%edx),%edx     // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    push %ecx           // Store random variable to stack
    pop  %ecx           // Load back random variable from stack
    mov -16(%ebp), %eax // Restore EAX value
    mov  -4(%ebp), %edx // Restore EDX value

    NOP_SPACER          // Variant 2: protected, load & store flush
                        // Expect no leakage from here.
    mov (%eax),%eax     // Load TTest variable 1
    push %ecx           // Flush store path
    pop  %ecx           // Flush load path
    mov (%edx),%edx     // Load TTest variable 2

    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    push %ecx           // Store random variable to stack
    pop  %ecx           // Load back random variable from stack
    mov -16(%ebp), %eax // Restore EAX value
    mov  -4(%ebp), %edx // Restore EDX value

    NOP_SPACER          // Variant 3: protected, load flush only.
                        // Flush data load / store path
    mov (%eax),%eax     // Load TTest variable 1
    mov -8(%ebp), %ecx  // Flush load path
    mov (%edx),%edx     // Load TTest variable 2
    
    NOP_SPACER          // Barrier between variants. ------------------------
                        // Flush data load / store path
    push %ecx           // Store random variable to stack
    pop  %ecx           // Load back random variable from stack
    mov -16(%ebp), %eax // Restore EAX value
    mov  -4(%ebp), %edx // Restore EDX value

    NOP_SPACER          // Variant 4: protected, store flush only.
                        // Expect no leakage from here.
    mov (%eax),%eax     // Load TTest variable 1
    mov %ecx, -8(%ebp)  // Flush load path
    mov (%edx),%edx     // Load TTest variable 2

    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

