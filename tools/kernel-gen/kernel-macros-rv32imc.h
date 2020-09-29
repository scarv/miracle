
// ABI argument registers
#define ARG_0 a0
#define ARG_1 a1
#define ARG_2 a2
#define ARG_3 a3
#define TMP_0 t0
#define TMP_1 t1 
#define TMP_2 t2 
#define TMP_3 t3 
#define STACK sp


#define GOTO(LABEL)               j    LABEL
#define MOVE(RD,RS)               mv   RD, RS
#define ZERO_REG(RD)              xor  RD,RD,RD
#define LOAD_UBYTE_RI(RD,RA,IMM)  lbu  RD,IMM(RA) 
#define LOAD_UHALF_RI(RD,RA,IMM)  lhu  RD,IMM(RA)
#define LOAD_WORD_RI(RD,RA,IMM)   lw   RD,IMM(RA)
#define STORE_BYTE_RI(RS,RB,IMM)  sb   RS,IMM(RB) 
#define STORE_HALF_RI(RS,RB,IMM)  sh   RS,IMM(RB)
#define STORE_WORD_RI(RS,RB,IMM)  sw   RS,IMM(RB)
#define XOR_RR(RD,RA,RM)          xor  RD,RA,RM
#define XOR_RI(RD,RA,IMM)         xori RD,RA,IMM
#define ADD_RR(RD,RN,RM )         add  RD,RN,RM  
#define ADD_RI(RD,RA,IMM)         addi RD,RD,IMM
#define SHIFT_LEFT_RI(RD,RA,IMM)   sll RD,RA,IMM 
#define SHIFT_RIGHT_RI(RD,RA,IMM)  srl RD,RA,IMM 
#define ANOP                      nop
#define MNOP                      nop           
#define MULTIPLY_RR (RD,RA,RB)    mul  RD,RM,RD 

#define FUNC_ENTER                xor t0, t0, t0;\
                                  xor t1, t1, t1;\
                                  xor t2, t2, t2;\
                                  xor t3, t3, t3;\

#define FUNC_ENTER_SHORT          
                                  
                                  
                                  

#define FUNC_RETURN_SHORT         ret  ;\

#define FUNC_RETURN               ret  ;\
                                  nop

#define NOP_SPACER                nop;nop;nop;nop;nop;nop;nop;nop;
