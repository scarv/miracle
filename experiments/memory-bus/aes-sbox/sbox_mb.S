
// 
// r5 - Address of the input message byte array
// r6 - Address of the key byte array
// r7 - Address of the SBOX array
// 
    
and  r11, r0, r0        // Load 0 into r11

l0:

    lbu   r3, r5, r11   // Load input data byte i; r3 = mem[r11+r5]
    lbu   r4, r6, r11   // Load round key byte i ; r4 = mem[r11+r6]

    xor   r3, r3, r4    // XOR data byte and key byte
    
    lbu   r4, r7, r3    // Load SBOX[data ^ key]
    sb    r4, r5, r11   // Store back.

    addi  r11, r11, 1   // Increment r11
    rsubi r12, r11, 16
    blti  r12, l0

l0_end:

