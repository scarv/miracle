
// ABI argument registers
#define ARG_0 r5
#define ARG_1 r6
#define ARG_2 r7
#define ARG_3 r8


#define LOAD_UBYTE_RI(RD,RB,IMM)  lbui RD,RN,IMM 
#define LOAD_UHALF_RI(RD,RB,IMM)  lhui RD,RN,IMM
#define LOAD_WORD_RI(RD,RB,IMM)   lwi  RD,RN,IMM
#define STORE_BYTE_RI(RS,RB,IMM)  sbi  RD,RN,IMM 
#define STORE_HALF_RI(RS,RB,IMM)  shi  RD,RN,IMM
#define STORE_WORD_RI(RS,RB,IMM)  swi  RD,RN,IMM
#define XOR_RR(RD,RA,RM)          xor  RD,RA,RM
#define XOR_RI(RD,RA,IMM)         xori RD,RA,IMM
#define ADD_RR(RD,RN,RM )         add  RD,RN,RM  
#define ADD_RI(RD,RA,IMM)         addi RD,RD,IM 
#define SHIFT_LEFT_RI(RD,RA,IMM)  bsll RD,RD,RS 
#define SHIFT_RIGHT_RI(RD,RA,IMM) bsrl RD,RD,RS 
#define ANOP                      nop
#define MNOP                      nop           
#define MULTIPLY_RR (RD,RA,RB)    mul  RD,RM,RD 

#define FUNC_ENTER                nop
#define FUNC_RETURN               rtsd r15,8 ;\
                                  nop
