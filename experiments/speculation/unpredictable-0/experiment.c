
/*!
@defgroup experiments-speculation-unpredictable-0-code Experiment Code
@{
@ingroup  experiments-speculation-unpredictable-0
*/

#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#define RLEN 1

//! Randomness array. Managed by SCASS.
uint8_t randomness[RLEN];

uint8_t  di1_fixed,di1_rand ; //!< TTest random input values.
uint8_t  di2_fixed,di2_rand ; //!< TTest random input values.

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"di1" , 1, &di1_rand, &di1_fixed, SCASS_FLAGS_TTEST_IN},
{"di2" , 1, &di2_rand, &di2_fixed, SCASS_FLAGS_TTEST_IN}
};

//! Declaration for the experiment payload function in ldst-byte.S
extern void     * experiment_payload(
    uint8_t d1,
    uint8_t d2,
    uint8_t br
);

/*!
@details Does nothing.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< SCASS Framework configuration object.
) {
    return 0;
}

/*!
@details Runs the experiment, then finishes.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg,  //!< SCASS Framework configuration object.
    char               fixed //!< used fixed variants of variables?
){

    uint8_t d1 = (fixed ? di1_fixed: di1_rand);
    uint8_t d2 = (fixed ? di2_fixed: di2_rand);
    uint8_t br = randomness[0] & 0x1;

    uas_bsp_trigger_set();
    
    experiment_payload(
        d1,
        d2,
        br
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "speculation/unpredictable-0";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 2                    ;
    cfg -> randomness            = randomness;
    cfg -> randomness_len        = RLEN;
    cfg -> randomness_refresh_rate=1;

}

//! @}

