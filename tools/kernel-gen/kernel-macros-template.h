
//
// Load unsigned byte into RD, using register + immediate addressing
//
#define LOAD_UBYTE_RI(RD,RB,IMM)\
    .error "Macro 'LOAD_UBYTE_RI' not implemented"

//
// Load unsigned halfword into RD, using register + immediate addressing
//
#define LOAD_UHALF_RI(RD,RB,IMM)\
    .error "Macro 'LOAD_UHALF_RI' not implemented"

//
// Load word into RD, using register + immediate addressing
//
#define LOAD_WORD_RI(RD,RB,IMM)\
    .error "Macro 'LOAD_WORD_RI' not implemented"

//
// Store byte from RS into MEM[GPR[RB]+IMM]
//
#define STORE_BYTE_RI(RS,RB,IMM)\
    .error "Macro 'STORE_BYTE_RI' not implemented"

//
// Store halfword from RS into MEM[GPR[RB]+IMM]
//
#define STORE_HALF_RI(RS,RB,IMM)\
    .error "Macro 'STORE_HALF_RI' not implemented"

//
// Store word from RS into MEM[GPR[RB]+IMM]
//
#define STORE_WORD_RI(RS,RB,IMM)\
    .error "Macro 'STORE_WORD_RI' not implemented"

//
// XOR RA and RB, put result in RD
//
#define XOR_RR(RD,RA,RB)\
    .error "Macro 'XOR_RR' not implemented"

//
// XOR RA and IMM, put result in RD
//
#define XOR_RI(RD,RA,IMM)\
    .error "Macro 'XOR_RI' not implemented"

//
// ADD RA and RB, put result in RD
//
#define ADD_RR(RD,RA,IMM)\
    .error "Macro 'ADD_RR' not implemented"

//
// ADD RA and IMM, put result in RD
//
#define ADD_RI(RD,RA,IMM)\
    .error "Macro 'ADD_RI' not implemented"

//
// Shift left RA by IMM, put result in RD
//
#define SHIFT_LEFT_RI(RD,RA,IMM)\
    .error "Macro 'SHIFT_LEFT_RI' not implemented"

//
// Shift right RA by IMM, put result in RD
//
#define SHIFT_RIGHT_RI(RD,RA,IMM)\
    .error "Macro 'SHIFT_RIGHT_RI' not implemented"

//
// Architectural .error "Macro '' not implemented" instruction.
//
#define ANOP\
    .error "Macro 'ANOP' not implemented"

//
// Micro-Architectural .error "Macro '' not implemented" instruction.
//
#define MNOP\
    .error "Macro 'MNOP' not implemented"

//
// Multiply RA by RB, put result in RD
//
#define MULTIPLY_RR (RD,RA,RB)\
    .error "Macro 'MULTIPLY_RR' not implemented"

