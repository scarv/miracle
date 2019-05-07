
/*!
@file experiment.h
@brief Experiment header file for the NOPS translation experiment.
*/

#include "uas_control.h"

#ifndef EXPERIMENT_H
#define EXPERIMENT_H

/*!
@brief Initialise any data needed for the experiment.
@returns 0 if successful, non-zero otherwise.
*/
uint8_t experiment_init();

/*!
@brief Run the experiment once
@returns 0 if successful, non-zero otherwise.
*/
uint8_t experiment_run();

#endif
