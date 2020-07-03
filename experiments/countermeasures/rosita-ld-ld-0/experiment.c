
/*!
@defgroup experiments-countermeasures-rosita-ld-ld-code Experiment Code
@{
@ingroup  experiments-countermeasures-rosita-ld-ld
*/

#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#define RLEN 8

//! Randomness array. Managed by SCASS.
uint8_t randomness[RLEN];

uint32_t di1_fixed,di1_rand ; //!< TTest random input values.
uint32_t di2_fixed,di2_rand ; //!< TTest random input values.
uint32_t result;

uint32_t d1;
uint32_t d2;

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"di1" , 4, &di1_rand, &di1_fixed, SCASS_FLAGS_TTEST_IN},
{"di2" , 4, &di2_rand, &di2_fixed, SCASS_FLAGS_TTEST_IN},
};

/*!
@brief Declaration for the experiment payload function in experiment_payload.S
*/
extern uint32_t experiment_payload(
    uint32_t * d1,
    uint32_t * d2,
    uint32_t   rnd_mask
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

    uint32_t wrd_mask = 0;

    for(unsigned int i = 0; i < sizeof(int); i ++) {
        wrd_mask |= ((uint32_t)randomness[i + 0]) << (8*i);
    }

    result       = 0;
    d1  = (fixed ? di1_fixed: di1_rand) ^ wrd_mask;
    d2  = (fixed ? di2_fixed: di2_rand) ^ wrd_mask;

    uas_bsp_trigger_set();
    
    result = experiment_payload(
        &d1,
        &d2,
        0
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "countermeasures/rosita-ld-ld-0";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 2                    ;
    cfg -> randomness            = randomness;
    cfg -> randomness_len        = 0;
    cfg -> randomness_refresh_rate=0;

}

//! @}

