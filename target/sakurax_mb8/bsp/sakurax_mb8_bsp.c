
/*!
@ingroup targets-bsp
@{
@file sakurax_mb8_bsp.c
@brief Contains BSP function definitions specific to the SAKURAX MB8 FPGA
    bitstream image.
@details 
*/

#include <stdint.h>

#include "uas_bsp.h"

static volatile uint32_t * UART_RX   = (uint32_t*)0x40600000;
static volatile uint32_t * UART_TX   = (uint32_t*)0x40600004;
static volatile uint32_t * UART_STAT = (uint32_t*)0x40600008;
static volatile uint32_t * UART_CTRL = (uint32_t*)0x4060000C;

const uint32_t UART_CTRL_RST_TX_FIFO = 0x00000001;
const uint32_t UART_CTRL_RST_RX_FIFO = 0x00000002;
const uint32_t UART_CTRL_INT_ENA     = 0x00000010;

const uint32_t UART_STATUS_RX_VALID  = 0x00000001;
const uint32_t UART_STATUS_TX_FULL   = 0x00000008;


static volatile uint32_t * GPIO = (uint32_t*)0x40000000;

const uint32_t GPIO_TRIGGER = 0x00000001;
const uint32_t GPIO_GPO     = 0x00000002;


/*!
*/
uint8_t uas_bsp_init_target(){

    // Clear the UART RX/TX FIFOs and disable it's interrupts
    UART_CTRL[0] = (UART_CTRL_RST_TX_FIFO |
                    UART_CTRL_RST_RX_FIFO );

    // Set the GPO bit to indicate we are running, and clear the trigger.
    GPIO[0] |= (GPIO_GPO & ~GPIO_TRIGGER);

    return 0;

}

/*!
*/
uint8_t uas_bsp_uart_rd_char(){
    while(!(UART_STAT[0] & UART_STATUS_RX_VALID)) {
        // Do nothing.
    }
    return (uint8_t)UART_RX[0];
}

/*!
*/
void    uas_bsp_uart_wr_char(
    uint8_t tosend
){
    while(UART_STAT[0] & UART_STATUS_TX_FULL) {
        // Do nothing.
    }
    UART_TX[0] = (uint32_t)tosend;
}


/*!
*/
volatile void * uas_bsp_trigger_set(){
    GPIO[0] |= GPIO_TRIGGER;
    return 0;
}

/*!
*/
volatile void * uas_bsp_trigger_clear(){
    GPIO[0] &= ~GPIO_TRIGGER;
    return 0;
}


//! }@
