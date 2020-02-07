
#define FUNC_ENTER                pushl %ebp        ; \
                                  movl  %esp, %ebp  ; \
                                  

#define FUNC_RETURN               movl  %ebp, %esp  ; \
                                  popl  %ebp        ; \
                                  ret               ;

#define NOP_SPACER                nop;nop;nop;nop;nop;nop;nop;nop;
