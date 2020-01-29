
/*!
@ingroup targets-bsp
@{
@file intel_d2000_bsp.c
@brief Contains BSP function definitions specific to the Intel D2000 target.
@details 
*/

#include <stdint.h>

#include <qm_common.h>
#include <qm_uart.h>
#include <qm_pinmux.h>
#include <qm_gpio.h>

#include "uas_bsp.h"


/*!
*/
uint8_t uas_bsp_init_target(){


    return 0;

}

/*!
*/
uint8_t uas_bsp_uart_rd_char(){
    return 0;
}

/*!
*/
void    uas_bsp_uart_wr_char(
    uint8_t tosend
){
}


/*!
*/
volatile void * uas_bsp_trigger_set(){
    return 0;
}

/*!
*/
volatile void * uas_bsp_trigger_clear(){
    return 0;
}


//! }@

