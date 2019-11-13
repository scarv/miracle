
/*!
@defgroup bsp-lpc1114 LPC1114 (ARM M0)
@file target_bsp.c
@brief Contains BSP function definitions specific to the lpc111x SoC
@details Mostly acts as a wrapper around the SCALE BSP for the SoC
*/

#include <stdint.h>

// These two come from the external/scale-hw repository.
#include "bsp.h"
#include "scale.h"

#include "uas_bsp.h"

scale_conf_t scale_conf;

/*!
*/
uint8_t uas_bsp_init_target(){
    
    if(scale_init(&SCALE_CONF)) {
        scale_gpio_wr(SCALE_GPIO_PIN_GPO, 1);
        scale_gpio_wr(SCALE_GPIO_PIN_TRG, 0);
        return 0;
    } else {
        scale_gpio_wr(SCALE_GPIO_PIN_GPO, 0);
        scale_gpio_wr(SCALE_GPIO_PIN_TRG, 1);
        return 1;
    }
}

/*!
*/
uint8_t uas_bsp_uart_rd_char(){
    return scale_uart_rd(SCALE_UART_MODE_BLOCKING);
}

/*!
*/
void    uas_bsp_uart_wr_char(
    uint8_t tosend
){
    return scale_uart_wr(SCALE_UART_MODE_BLOCKING, tosend);
}


/*!
*/
volatile void * uas_bsp_trigger_set(){
    scale_gpio_wr(SCALE_GPIO_PIN_TRG, 1);
    return NULL;
}

/*!
*/
volatile void * uas_bsp_trigger_clear(){
    scale_gpio_wr(SCALE_GPIO_PIN_TRG, 0);
    return NULL;
}

