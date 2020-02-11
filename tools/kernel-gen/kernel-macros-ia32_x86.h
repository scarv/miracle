
#define FUNC_ENTER                pushl %ebp        ; \
                                  movl  %esp, %ebp  ; \
                                  pushl %eax        ; \
                                  pushl %ebx        ; \
                                  pushl %ecx        ; \
                                  pushl %edx        ; \
                                  

#define FUNC_RETURN               popl  %edx        ; \
                                  popl  %ecx        ; \
                                  popl  %ebx        ; \
                                  popl  %eax        ; \
                                  movl  %ebp, %esp  ; \
                                  popl  %ebp        ; \
                                  ret               ;

#define NOP_SPACER                nop;nop;nop;nop;nop;nop;nop;nop;
