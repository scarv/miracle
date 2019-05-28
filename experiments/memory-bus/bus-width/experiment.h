
/*!
@file experiment.h
@brief Experiment header file for the Load byte 0 experiment.
*/

#include "scass/scass_target.h"

#ifndef EXPERIMENT_H
#define EXPERIMENT_H

/*!
@brief Initialise any data needed for the experiment.
@returns 0 if successful, non-zero otherwise.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< PRNG / data access
);

/*!
@brief Run the experiment once
@returns 0 if successful, non-zero otherwise.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg //!< PRNG / data access
);

/*!
@brief Responsible for configuring the scass communication object.
*/
void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
);

#endif
