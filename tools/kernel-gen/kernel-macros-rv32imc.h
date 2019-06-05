
// ABI argument registers
#define ARG_0 a0
#define ARG_1 a1
#define ARG_2 a2
#define ARG_3 a3
#define TMP_0 t0
#define TMP_1 t1 
#define TMP_2 t2 
#define TMP_3 t3 


#define LOAD_UBYTE_RI(RD,RA,IMM)  lbu  RD,RA,IMM 
#define LOAD_UHALF_RI(RD,RA,IMM)  lhu  RD,RA,IMM
#define LOAD_WORD_RI(RD,RA,IMM)   lw   RD,RA,IMM
#define STORE_BYTE_RI(RS,RB,IMM)  sb   RS,RB,IMM 
#define STORE_HALF_RI(RS,RB,IMM)  sh   RS,RB,IMM
#define STORE_WORD_RI(RS,RB,IMM)  sw   RS,RB,IMM
#define XOR_RR(RD,RA,RM)          xor  RD,RA,RM
#define XOR_RI(RD,RA,IMM)         xori RD,RA,IMM
#define ADD_RR(RD,RN,RM )         add  RD,RN,RM  
#define ADD_RI(RD,RA,IMM)         addi RD,RD,IM 
#define SHIFT_LEFT_RI(RD,RA,IMM)   sll RD,RD,RS 
#define SHIFT_RIGHT_RI(RD,RA,IMM)  srl RD,RD,RS 
#define ANOP                      nop
#define MNOP                      nop           
#define MULTIPLY_RR (RD,RA,RB)    mul  RD,RM,RD 

#define FUNC_ENTER                nop
#define FUNC_RETURN               ret  ;\
                                  nop
