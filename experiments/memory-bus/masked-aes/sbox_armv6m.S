
// 
// r0 - Address of the input message byte array
// r1 - Address of the key byte array
// r2 - Address of the SBOX array
// r3 - The mask
// 
    
ldrb r6, [r3, #0]
movs r5, #0
movs r6, #0
movs r7, #0
mov  r8, r7

l0:
    nop
    ldrb r5, [r1, r7] // Load round key byte i
    ldrb r6, [r0, r7] // Load input data byte i
    eor  r5, r6       // XOR data byte and key byte
    ldrb r4, [r2, r5] // Load SBOX[data ^ key]
    strb r4, [r0, r7] // Store back.
    ldrb r5, [r3, #0]
    movs r6, #0
    movs r4, #1
    add  r7, r7, r4
    cmp  r7, #16
    bne  l0

l0_end:

