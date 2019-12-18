
// ABI argument registers
#define ARG_0 r5
#define ARG_1 r6
#define ARG_2 r7
#define ARG_3 r8
#define TMP_0 r9
#define TMP_1 r10
#define TMP_2 r11
#define TMP_3 r12

#define GOTO(LABEL)               bri  LABEL
#define MOVE(RD,RS)               ori  RD, RS, 0
#define ZERO_REG(RD)              xor  RD,RD,RD
#define LOAD_UBYTE_RI(RD,RA,IMM)  lbui RD,RA,IMM 
#define LOAD_UHALF_RI(RD,RA,IMM)  lhui RD,RA,IMM
#define LOAD_WORD_RI(RD,RA,IMM)   lwi  RD,RA,IMM
#define STORE_BYTE_RI(RS,RB,IMM)  sbi  RS,RB,IMM 
#define STORE_HALF_RI(RS,RB,IMM)  shi  RS,RB,IMM
#define STORE_WORD_RI(RS,RB,IMM)  swi  RS,RB,IMM
#define XOR_RR(RD,RA,RM)          xor  RD,RA,RM
#define XOR_RI(RD,RA,IMM)         xori RD,RA,IMM
#define ADD_RR(RD,RN,RM )         add  RD,RN,RM  
#define ADD_RI(RD,RA,IMM)         addi RD,RD,IMM
#define SHIFT_LEFT_RI(RD,RA,IMM)  bslli RD,RA,IMM
#define SHIFT_RIGHT_RI(RD,RA,IMM) bsrli RD,RA,IMM
#define ANOP                      nop
#define MNOP                      nop           
#define MULTIPLY_RR (RD,RA,RB)    mul  RD,RM,RD 

#define FUNC_ENTER                xor r9 , r9 , r9 ;\
                                  xor r10, r10, r10;\
                                  xor r11, r11, r11;\
                                  xor r12, r12, r12;\

#define FUNC_RETURN               rtsd r15,8 ;\
                                  nop
