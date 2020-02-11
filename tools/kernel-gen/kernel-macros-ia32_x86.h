
#define FUNC_ENTER                pushl %eax        ; \
                                  pushl %ebx        ; \
                                  pushl %ecx        ; \
                                  pushl %edx        ; \
                                  pushl %ebp        ; \
                                  movl  %esp, %ebp  ; \
                                  

#define FUNC_RETURN               movl  %ebp, %esp  ; \
                                  popl  %ebp        ; \
                                  popl  %edx        ; \
                                  popl  %ecx        ; \
                                  popl  %ebx        ; \
                                  popl  %eax        ; \
                                  ret               ;

#define NOP_SPACER                nop;nop;nop;nop;nop;nop;nop;nop;
