
.syntax unified

// 
// r0 - Address of the input message byte array
// r1 - Address of the key byte array
// r2 - Address of the SBOX array
// 

movs r3, #0
movs r4, #0
movs r5, #0
movs r6, #0
mov  r7, r0
adds r7, #16

l0:
    ldrb r3, [r0]       // Load masked message
    ldrb r4, [r1]       // Load key
    eors r3,  r4        // Key ^ Message
    ldrb r5, [r2, r3]   // SBOX[key^message]
    strb r5, [r0]       // Store back SBOX[key^message]

    adds r0, #1
    cmp  r0, r7
    blt  l0

l0_end:

