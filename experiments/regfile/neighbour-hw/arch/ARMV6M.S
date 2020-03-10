#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload: // r0 - TTest variable.

    FUNC_ENTER

    mov r1, r0      // Move r0 to r1
    eor r0, r0      // Zero r0
    eor r2, r2      // Zero r2
    eor r3, r3      // Zero r3

    NOP_SPACER

    mov r0, r0      // Skip over accessing r1
    mov r3, r3      //

    NOP_SPACER
    
    mov r2, r2      // Skip over accessing r1
    mov r3, r3      //

    NOP_SPACER
    
    mov r4, r4      // Skip over accessing r1
    mov r5, r5      //

    NOP_SPACER
    
    mov r0, r0      // Skip over accessing r1
    mov r5, r5      //
    
    NOP_SPACER
    
    mov r2, r2      // Skip over accessing r1
    mov r5, r5      //
    
    NOP_SPACER

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
