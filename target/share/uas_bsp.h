
/*!
@ingroup targets-bsp
@{
*/

/*!
@file uas_bsp.h
@brief Board support package header
@details Contains declarations of abstraction functions for target specific IO
interractions and configurations.
*/

#include <stdint.h>
#include <stdlib.h>

#include "scass/scass_target.h"

#ifndef UAS_BSP_H
#define UAS_BSP_H

#define XSTR(a) STR(a)
#define STR(a) #a


/*!
@brief Initialise the target platform.
@details Used to setup things like GPIO, Clock frequency and UART etc.
@returns 0 on success, non-zero on failure.
@note This function must be implemented by the target.
*/
uint8_t uas_bsp_init_target(
    scass_target_cfg * cfg //!< The scass target object to configure.
);

/*!
@brief Read a single character from the target UART port.
@warning This function will *block* until a character is recieved.
@returns The recieved character.
@note This function must be implemented by the target.
*/
uint8_t uas_bsp_uart_rd_char();

/*!
@brief Write a single character to the target UART port.
@warning This function will *block* until the character is sent.
@returns void
@note This function must be implemented by the target.
*/
void    uas_bsp_uart_wr_char(
    uint8_t tosend //!< The character to send.
);

/*!
@brief Write a 32-bit integer as a hex string to the UART
@details Pads the value with zeros. Does not add a preceeding '0x'.
@returns void
*/
void    uas_bsp_uart_wr_hex(
    uint32_t to_put //!< The value to print.
);

/*!
@brief Set the trace capture trigger signal.
@note This function must be implemented by the target.
*/
volatile void * uas_bsp_trigger_set();

/*!
@brief Clear the trace capture trigger signal.
@note This function must be implemented by the target.
*/
volatile void * uas_bsp_trigger_clear();


/*!
@brief Read a string from the UART port.
@details Read a known length string of bytes from the UART port.
@warning This function will *block* until the string is completely recieved.
@returns void
*/
void    uas_bsp_uart_rd_strn(
    int    nbytes , //!< The number of bytes to recieve.
    char * recv     //!< The pre-allocated recieve buffer.
);

/*!
@brief Write a null-terminated string to the UART port.
@warning This function will *block* until the string is sent.
@returns void
*/
void    uas_bsp_uart_wr_str(
    char * tosend //!< The null terminated string to send.
);

/*!
@brief Write a string to the UART port.
@details Sends the first `nbytes` fo the supplied string.
@warning This function will *block* until the string is sent.
@returns void
*/
void    uas_bsp_uart_wr_strn(
    int    nbytes, //!< The number of bytes to send.
    char * tosend //!< The terminated string to send.
);

#endif

//! }@
