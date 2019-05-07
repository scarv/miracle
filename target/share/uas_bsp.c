
#include "uas_bsp.h"



/*!
@note Function implemented over uas_bsp_uart_rd_char
*/
void    uas_bsp_uart_rd_strn(
    int    nbytes ,
    char * recv    
){
    for(int i = 0; i < nbytes; i ++) {
        recv[i] = uas_bsp_uart_rd_char();
    }   
}


/*!
@note Function implemented over uas_bsp_uart_wr_char
*/
void    uas_bsp_uart_wr_str(
    char * tosend
){
    int i = 0;
    while(tosend[i] != 0) {
        uas_bsp_uart_wr_char(tosend[i]);
        i++;
    }
}

/*!
@note Function implemented over uas_bsp_uart_wr_char
*/
void    uas_bsp_uart_wr_strn(
    int    nbytes,
    char * tosend
){
    for(int i = 0; i < nbytes; i++) {
        uas_bsp_uart_wr_char(tosend[i]);
    }
}

