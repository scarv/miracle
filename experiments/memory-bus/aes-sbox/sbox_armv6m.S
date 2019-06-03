
l0:
    movs r7, #0

    ldrb r6, [r0, r7]   // Load input data byte i
    ldrb r5, [r1, r7]   // Load round key byte i

    eor  r5, r6         // XOR data byte and key byte
    
    ldrb r4, [r2, r5]   // Load SBOX[data ^ key]
    strb r4, [r0, r7]   // Store back.

    movs r6, #1
    add  r7, r7, r6
    cmp  r7, #16
    bne  l0
