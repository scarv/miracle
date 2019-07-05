
// 
// r0 - Address of the input message byte array
// r1 - Address of the key byte array
// r2 - Address of the SBOX array
// r3 - The mask
// 
    
movs r4, #0
movs r5, #0
movs r6, #0
movs r7, #0
mov  r8, r7

l0:
    ldrb r5, [r3]
    nop; nop
    ldrb r5, [r1, r7] // Load round key byte i
    nop; nop
    ldrb r6, [r0, r7] // Load input data byte i
    nop; nop
    eor  r5, r6       // XOR data byte and key byte
    nop; nop
    ldrb r4, [r2, r5] // Load SBOX[data ^ key]
    nop; nop
    strb r4, [r0, r7] // Store back.
    movs r5, #0
    movs r6, #0
    movs r4, #1
    add  r7, r7, r4
    cmp  r7, #16
    bne  l0

l0_end:

