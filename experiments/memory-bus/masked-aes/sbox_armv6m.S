
.syntax unified

// 
// r0 - Address of the input message byte array
// r1 - Address of the key byte array
// r2 - Address of the SBOX array
// r3 - The mask
// 

mov     r4, r0
adds    r4, r4, #16             // End of loop value

nop
ldrb    r5, [r3]
ldrb    r5, [r0]                // Load masked message byte
ldrb    r6, [r1]                // Load key byte

l0:

    eors r5, r5, r6             // r5 = key ^ masked message

    ldrb r6, [r2, r5]           // r6 = masked_sbox[key^masked message]
    nop   
    ldrb r5, [r0    ]           // Load masked message byte for next loop

    strb r6, [r0    ]           // store back to message array
    
    adds r0, r0, #1             // Increment data pointer
    cmp  r0, r4                 // Continue loop?

    ldrb r6, [r1    ]           // Load key byte

    adds r1, r1, #1             // Increment key  pointer
    blt  l0

eors r5, r5, r6             // r5 = key ^ masked message

ldrb r6, [r2, r5]           // r6 = masked_sbox[key^masked message]
strb r6, [r0, r5]           // store back to message array

l0_end:

