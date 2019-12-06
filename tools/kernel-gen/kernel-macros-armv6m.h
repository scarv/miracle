
// ABI argument registers
#define ARG_0 r0
#define ARG_1 r1
#define ARG_2 r2
#define ARG_3 r3
#define TMP_0 r4
#define TMP_1 r5
#define TMP_2 r6
#define TMP_3 r7

#define __hash #
#define f(x) x

#define GOTO(LABEL)               b    LABEL
#define MOVE(RD,RS)               mov  RD, RS
#define ZERO_REG(RD)              eor  RD,RD
#define LOAD_UBYTE_RI(RD,RB,IMM)  ldrb RD,[RB,f(__hash)IMM]
#define LOAD_UHALF_RI(RD,RB,IMM)  ldrh RD,[RB,f(__hash)IMM]
#define LOAD_WORD_RI(RD,RB,IMM)   ldr  RD,[RB,f(__hash)IMM]
#define STORE_BYTE_RI(RS,RB,IMM)  strb RS,[RB,f(__hash)IMM]
#define STORE_HALF_RI(RS,RB,IMM)  strh RS,[RB,f(__hash)IMM]
#define STORE_WORD_RI(RS,RB,IMM)  str  RS,[RB,f(__hash)IMM]
#define XOR_RR(RD,RA,RM)          eor  RD,RM 
#define XOR_RI(RD,RA,IMM)         .error "No xor reg imm on ARMv6M"
#define ADD_RR(RD,RN,RM )         add  RD,RN,RM  
#define ADD_RI(RD,RA,IMM)         adds RD,RD,IM 
#define SHIFT_LEFT_RI(RD,RA,IMM)  lsls RD,RD,RS 
#define SHIFT_RIGHT_RI(RD,RA,IMM) lsrs RD,RD,RS 
#define ANOP                      nop
#define MNOP                      nop           
#define MULTIPLY_RR (RD,RA,RB)    muls RD,RM,RD 

#define FUNC_ENTER                push {r4, r5, r6, r7, lr} ; \
                                  eor   r4, r4 ; \
                                  eor   r5, r5 ; \
                                  eor   r6, r6 ; \
                                  eor   r7, r7 ; \

#define FUNC_RETURN               pop  {r4, r5, r6, r7, pc}
