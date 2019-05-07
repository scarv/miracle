
/*!
@file control.h
@brief Function/constant declarations for the experiment control interface.
@details All experiments are controlled via a UART interface which allows
updating of randomness, changing of parameters, reading/writing key and
message material etc.
*/

#include <stdint.h>

#ifndef UAS_CONTROL_H
#define UAS_CONTROL_H

#define UAS_CMD_HELLOWORLD      'H'
#define UAS_CMD_INIT_EXPERIMENT 'I'
#define UAS_CMD_RUN_EXPERIMENT  'R'
#define UAS_CMD_SEED_PRNG       'P'

#define UAS_RSP_OKAY            '0'
#define UAS_RSP_ERROR           '!'

/*!
@brief Enter the main experiment control loop
@details Enters an infinite loop, which reads from the UART and responds
to the commands as appropriate.
@warning This function does not return!
*/
void uas_ctrl_loop();

#endif
