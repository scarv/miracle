
// 
// a0 - Address of the input message byte array
// a1 - Address of the key byte array
// a2 - Address of the SBOX array
// 

addi t0, a0, 16

l0:

    lbu  t1, 0(a0)      // Load message byte
    lbu  t2, 0(a1)      // Load key     byte

    xor  t3, t1, t2     // t3 = message ^ key

    add  t4, t3, a2     // t4 = Index into SBOX

    lbu  t5, 0(t4)      // Load SBOX'd value
    
    addi a1, a1, 1      // Increment key byte array pointer

    sb   t5, 0(a0)      // Store sboxed value back.

    addi a0, a0, 1      // Increment message array pointer.

    blt  a0, t0, l0

l0_end:

