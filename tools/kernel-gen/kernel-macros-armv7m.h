
// ABI argument registers
#define ARG_0 r0
#define ARG_1 r1
#define ARG_2 r2
#define ARG_3 r3

#define __hash #
#define f(x) x

#define LOAD_UBYTE_RI(RD,RB,IMM)  ldrb RD,[RB,f(__hash)IMM]
#define LOAD_UHALF_RI(RD,RB,IMM)  ldrh RD,[RB,f(__hash)IMM]
#define LOAD_WORD_RI(RD,RB,IMM)   ldr  RD,[RB,f(__hash)IMM]
#define STORE_BYTE_RI(RS,RB,IMM)  strb RD,[RB,f(__hash)IMM]
#define STORE_HALF_RI(RS,RB,IMM)  strh RD,[RB,f(__hash)IMM]
#define STORE_WORD_RI(RS,RB,IMM)  str  RD,[RB,f(__hash)IMM]
#define XOR_RR(RD,RA,RM)          eor  RD,RM 
#define XOR_RI(RD,RA,IMM)         .error "Not implemented XOR RRI ARM7-M"
#define ADD_RR(RD,RN,RM )         add  RD,RN,RM  
#define ADD_RI(RD,RA,IMM)         adds RD,RD,IM 
#define SHIFT_LEFT_RI(RD,RA,IMM)  lsls RD,RD,RS 
#define SHIFT_RIGHT_RI(RD,RA,IMM) lsrs RD,RD,RS 
#define ANOP                      nop
#define MNOP                      nop           
#define MULTIPLY_RR (RD,RA,RB)    muls RD,RM,RD 

#define FUNC_ENTER                push {r4, lr}
#define FUNC_RETURN               pop  {r4, pc}
