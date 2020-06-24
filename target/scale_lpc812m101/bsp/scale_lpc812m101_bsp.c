
/*!
@ingroup targets-bsp
@{
@file scale_lpc812m101_bsp.c
@brief Contains BSP function definitions specific to the lpc81x SoC
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
uint8_t uas_bsp_init_target(
    scass_target_cfg * cfg //!< The scass target object to configure.
){
    
    if(scale_init(&SCALE_CONF)) {
        scale_gpio_wr(SCALE_GPIO_PIN_GPO, 1);
        scale_gpio_wr(SCALE_GPIO_PIN_TRG, 0);
        return 0;
    } else {
        scale_gpio_wr(SCALE_GPIO_PIN_GPO, 0);
        scale_gpio_wr(SCALE_GPIO_PIN_TRG, 1);
        return 1;
    }
    
    // Set the current clock rate for SCASS.
    cfg -> sys_clk.clk_current  = SCALE_CONF.clock_freq_target*1000000;
    cfg -> sys_clk.ext_clk_rate         = 0;
    cfg -> sys_clk.clk_rates[0]         = cfg -> sys_clk.clk_current;
    cfg -> sys_clk.clk_source_avail     = SCASS_CLK_SRC_INTERNAL;
    cfg -> sys_clk.clk_source_current   = SCASS_CLK_SRC_INTERNAL;
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

//! }@
