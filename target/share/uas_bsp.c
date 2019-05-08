
#include "uas_bsp.h"


/*!
@note Implemented over uart_wr_char
*/
void    uas_bsp_uart_wr_hex(
    uint32_t to_put
){
    char * table = "0123456789ABCDEF";

    for(int i = 3; i >= 0; i --) {
        uint8_t tp      = to_put >> (8*i);
        uint8_t tp_lo   = tp      & 0xF;
        uint8_t tp_hi   = (tp>>4) & 0xF;
        uas_bsp_uart_wr_char(table[tp_hi]);
        uas_bsp_uart_wr_char(table[tp_lo]);
    }

}

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

