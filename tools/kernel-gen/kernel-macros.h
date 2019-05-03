
#ifndef __KERNEL_MACROS_H__
#define __KERNEL_MACROS_H__

#if ARCH_ARMV6M
    .error "No macros for ARCH_ARMV6M available yet"
#elif ARCH_ARMV7M
    .error "No macros for ARCH_ARMV7M available yet"
#elif ARCH_MICROBLAZE
    .error "No macros for ARCH_MICROBLAZE available yet"
#elif ARCH_RV32IMC
    .error "No macros for ARCH_RV32IMC available yet"
#else
    .error "No known architecture defined"
#endif


//
// Load unsigned byte into RD, using register + immediate addressing
//
#ifndef LOAD_UBYTE_RI
    .warning "Macro 'LOAD_UBYTE_RI' not defined"
#endif

//
// Load unsigned halfword into RD, using register + immediate addressing
//
#ifndef LOAD_UHALF_RI
    .warning "Macro 'LOAD_UHALF_RI' not defined"
#endif

//
// Load word into RD, using register + immediate addressing
//
#ifndef LOAD_WORD_RI
    .warning "Macro 'LOAD_WORD_RI' not defined"
#endif

//
// Store byte from RS into MEM[GPR[RB]+IMM]
//
#ifndef STORE_BYTE_RI
    .warning "Macro 'STORE_BYTE_RI' not defined"
#endif

//
// Store halfword from RS into MEM[GPR[RB]+IMM]
//
#ifndef STORE_HALF_RI
    .warning "Macro 'STORE_HALF_RI' not defined"
#endif

//
// Store word from RS into MEM[GPR[RB]+IMM]
//
#ifndef STORE_WORD_RI
    .warning "Macro 'STORE_WORD_RI' not defined"
#endif

//
// XOR RA and RB, put result in RD
//
#ifndef XOR_RR      
    .warning "Macro 'XOR_RR' not defined"
#endif

//
// XOR RA and IMM, put result in RD
//
#ifndef XOR_RI     
    .warning "Macro 'XOR_RI' not defined"
#endif

//
// ADD RA and RB, put result in RD
//
#ifndef ADD_RR      
    .warning "Macro 'ADD_RR' not defined"
#endif

//
// ADD RA and IMM, put result in RD
//
#ifndef ADD_RI     
    .warning "Macro 'ADD_RI' not defined"
#endif

//
// Shift left RA by IMM, put result in RD
//
#ifndef SHIFT_LEFT_RI
    .warning "Macro 'SHIFT_LEFT_RI' not defined"
#endif

//
// Shift right RA by IMM, put result in RD
//
#ifndef SHIFT_RIGHT_RI
    .warning "Macro 'SHIFT_RIGHT_RI' not defined"
#endif

//
// Architectural .warning "Macro '' not defined"
#endif instruction.
//
#ifndef ANOP\
    .warning "Macro 'ANOP' not defined"
#endif

//
// Micro-Architectural .warning "Macro '' not defined"
#endif instruction.
//
#ifndef MNOP\
    .warning "Macro 'MNOP' not defined"
#endif

//
// Multiply RA by RB, put result in RD
//
#ifndef MULTIPLY_RR 
    .warning "Macro 'MULTIPLY_RR' not defined"
#endif

#endif 

