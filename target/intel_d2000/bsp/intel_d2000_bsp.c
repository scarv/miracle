
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

#define TRIGGER_PIN QM_PIN_ID_10

/*!
*/
uint8_t uas_bsp_init_target(){

    qm_gpio_port_config_t cfg;
 
    cfg.direction = BIT(TRIGGER_PIN);
    qm_gpio_set_config(QM_GPIO_0, &cfg);

    qm_gpio_clear_pin(QM_GPIO_0, TRIGGER_PIN);

    qm_pmux_select(QM_PIN_ID_12, QM_PMUX_FN_2); /* configure UART_A_TXD */
    qm_pmux_select(QM_PIN_ID_13, QM_PMUX_FN_2); /* configure UART_A_RXD */
    qm_pmux_input_en(QM_PIN_ID_13, true);       /* UART_A_RXD is an input */

    qm_pmux_select(QM_PIN_ID_5, QM_PMUX_FN_2); /* Set clock out */

    return 0;

}

/*!
*/
uint8_t uas_bsp_uart_rd_char(){
	uint8_t c;
	while (qm_uart_read(QM_UART_0, &c, NULL) != 0);
	return c;
}

/*!
*/
void    uas_bsp_uart_wr_char(
    uint8_t tosend
){
	qm_uart_write(QM_UART_0, tosend);
}


/*!
*/
volatile void * uas_bsp_trigger_set(){
	qm_gpio_set_pin(QM_GPIO_0, TRIGGER_PIN);
    return 0;
}

/*!
*/
volatile void * uas_bsp_trigger_clear(){
	qm_gpio_clear_pin(QM_GPIO_0, TRIGGER_PIN);
    return 0;
}


//! }@

