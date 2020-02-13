
/*!
@ingroup targets-bsp
@{
@file nxp_lpc1115fbd48_bsp.c
@brief Contains BSP function definitions specific to the lpc111x SoC
*/

#include <stdint.h>

#include "lpc111x.h"

#include "uas_bsp.h"

//! Initialise the clock for the core.
static void uas_bsp_init_clock()
{
	// This function sets the main clock to the external crystal
	// The PLL input is theh external 16MHz oscillator
	// This is multiplied up to 48MHz for the main clock
	// MSEL = 2, PSEL = 1 see page 51 of UM10398 user manual
    SYSOSCCTRL      = 1; // Bypass enabled "Use this mode when using an
                         // external clock source instead of the crystal
                         // oscillator."
	SYSPLLCLKSEL    = 1; // select system oscillator
	SYSPLLCTRL      = (2 << 0) | (1 << 5); // set divisors/multipliers
	PDRUNCFG       &= ~BIT7; // Power up the PLL.
	SYSPLLCLKUEN    = 1; // inform PLL of update
	
	MAINCLKSEL      = 3; // Use PLL as main clock
	MAINCLKUEN      = 1; // Inform core of clock update

	GPIO0DIR       |= 3; // set direction to out for pin 1
	IOCON_PIO0_1   &= ~0x07;
	IOCON_PIO0_1   |= 1; // Makes PIO0_1 CLkOUT

	
	CLKOUTCLKSEL    = 3; // Set CLKOUT pin to system clock
	CLKOUTCLKDIV    = 10; // Enable CLKOUT without divider	
	CLKOUTUEN       = 0; // update above
	CLKOUTUEN       = 1; // update above
	while (!(CLKOUTUEN & 0x01));        /* Wait until updated */
	
}

//! Setup the UART baud rate.
static void uas_bsp_init_uart()
{
	SYSAHBCLKCTRL  |= BIT6 + BIT16; // Turn on clock for GPIO and IOCON
	// Enable UART RX function on PIO1_6
	IOCON_PIO1_6   |= BIT0;
	IOCON_PIO1_6   &= ~(BIT1+BIT2);
	// Enable UART TX function on PIO1_7
	IOCON_PIO1_7   |= BIT0;
	IOCON_PIO1_7   &= ~(BIT1+BIT2);
	// Turn on clock for UART
	SYSAHBCLKCTRL  |= BIT12;
	UARTCLKDIV      = 1;
	// PCLK = 48Mhz. Desired Baud rate = 9600
	// See table 199
	// 9600=48MHz/(16* (256*U0DLM + U0DLL)*(1+DivAddVal/MulVal))
	// 312.5 = (256*U0DLM+U0DLL)*(1+DivAddVal/MulVal)
	// let U0DLM=1, DivAddVal=0,MulVal =1
	// 312.5=256+U0DLL
	// U0DLL=56.5.
	// Choose U0DLL=56.
	// Actual baud rate achieved = 9615 - close enough.
	U0LCR          |= BIT7; // Enable divisor latch access
	U0FDR           = (1<<4)+0; // Set DivAddVal = 0; MulVal = 1
	U0DLL           = 56;
	U0DLM           = 1;
	U0LCR          &= ~BIT7; // Disable divisor latch access
	U0LCR          |= (BIT1+BIT0); // set word lenght to 8 bits.

}

/*!
*/
uint8_t uas_bsp_init_target(){
    uas_bsp_init_clock();
    uas_bsp_init_uart();
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
    return NULL;
}

/*!
*/
volatile void * uas_bsp_trigger_clear(){
    return NULL;
}

//! }@
