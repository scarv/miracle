
#include "lpc111x.h"

void main(void);
void __init__(void);
void default_handler(void);
// The following are 'declared' in the linker script
extern unsigned char  INIT_DATA_VALUES;
extern unsigned char  INIT_DATA_START;
extern unsigned char  INIT_DATA_END;
extern unsigned char  BSS_START;
extern unsigned char  BSS_END;

// the section "vectors" is placed at the beginning of flash 
// by the linker script
const void * Vectors[] __attribute__((section(".vectors"))) ={
	(void *)0x10002000, 	/* Top of stack / SRAM */ 
	__init__,   			/* Reset Handler */
	default_handler,	/* NMI */
	default_handler,	/* Hard Fault */
	0,	                /* Reserved */
	0,                  /* Reserved */
	0,                  /* Reserved */
	0,                  /* Reserved */
	0,                  /* Reserved */
	0,                  /* Reserved */
	0,                  /* Reserved */
	default_handler,	/* SVC */
	0,                 	/* Reserved */
	0,                 	/* Reserved */
	default_handler,   	/* PendSV */
	default_handler, 	/* SysTick */		
/* External interrupt handlers follow */
	default_handler, 	/* PIO0_0 */
	default_handler, 	/* PIO0_1 */
	default_handler, 	/* PIO0_2 */
	default_handler, 	/* PIO0_3 */
	default_handler, 	/* PIO0_4 */
	default_handler, 	/* PIO0_5 */
	default_handler, 	/* PIO0_6 */
	default_handler, 	/* PIO0_7 */
	default_handler, 	/* PIO0_8 */
	default_handler, 	/* PIO0_9 */
	default_handler, 	/* PIO0_10 */
	default_handler, 	/* PIO0_11 */
	default_handler,	/* PIO1_0 */
	default_handler ,  	/* C_CAN */
	default_handler, 	/* SSP1 */
	default_handler, 	/* I2C */
	default_handler, 	/* CT16B0 */
	default_handler, 	/* CT16B1 */
	default_handler, 	/* CT32B0 */
	default_handler, 	/* CT32B1 */
	default_handler, 	/* SSP0 */
	default_handler,	/* UART */
	default_handler, 	/* RESERVED */
	default_handler, 	/* RESERVED */
	default_handler, 	/* ADC */
	default_handler, 	/* WDT */
	default_handler, 	/* BOD */
	default_handler, 	/* RESERVED */
	default_handler, 	/* PIO3 */
	default_handler, 	/* PIO2 */
	default_handler, 	/* PIO1 */
	default_handler 	/* PIO0 */
};

void __init__() {
    // do global/static data initialization
	unsigned char *src;
	unsigned char *dest;
	unsigned len;
	src= &INIT_DATA_VALUES;
	dest= &INIT_DATA_START;
	len= &INIT_DATA_END-&INIT_DATA_START;
	while (len--)
		*dest++ = *src++;
// zero out the uninitialized global/static variables
	dest = &BSS_START;
	len = &BSS_END - &BSS_START;
	while (len--)
		*dest++=0;

    main();
}

void default_handler()
{
	while(1);
}
