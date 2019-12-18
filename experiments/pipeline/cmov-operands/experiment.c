
/*!
@defgroup experiments-pipeline-cmov-operands-code Experiment Code
@{
@ingroup  experiments-pipeline-cmov-operands
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
uint8_t  select             ; //!< which variable to select.
uint8_t  result             ; //!< Result of conditional move.

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"di1" , 1, &di1_rand, &di1_fixed, SCASS_FLAGS_TTEST_IN},
{"di2" , 1, &di2_rand, &di2_fixed, SCASS_FLAGS_TTEST_IN},
{"sel" , 1, &select  , &select   , SCASS_FLAG_INPUT    }
};

/*!
@brief Declaration for the experiment payload function in ldst-byte.S
@details Based on select, result is set to either d1 or d2.
*/
uint8_t experiment_payload(
    uint8_t result,
    uint8_t d1,
    uint8_t d2,
    uint8_t select
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
    result     = 0;
    uint8_t d1 = (fixed ? di1_fixed: di1_rand);
    uint8_t d2 = (fixed ? di2_fixed: di2_rand);

    uas_bsp_trigger_set();
    
    result = experiment_payload (
        result,
        d1,
        d2,
        select
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "pipeline/cmov-operands";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 3                    ;
    cfg -> randomness            = randomness;
    cfg -> randomness_len        = RLEN;
    cfg -> randomness_refresh_rate=0;

}

//! @}

