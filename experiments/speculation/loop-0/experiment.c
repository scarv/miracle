
/*!
*/

#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#define RLEN 4

//! Randomness array. Managed by SCASS.
uint8_t randomness[RLEN];

uint32_t di_fixed[6];
uint32_t di_rand [6];

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"di1" , 4, di_rand+0, di_fixed+0, SCASS_FLAGS_TTEST_IN},
{"di2" , 4, di_rand+1, di_fixed+1, SCASS_FLAGS_TTEST_IN},
{"di3" , 4, di_rand+2, di_fixed+2, SCASS_FLAGS_TTEST_IN},
{"di4" , 4, di_rand+3, di_fixed+3, SCASS_FLAGS_TTEST_IN},
{"di5" , 4, di_rand+4, di_fixed+4, SCASS_FLAGS_TTEST_IN},
{"di6" , 4, di_rand+5, di_fixed+5, SCASS_FLAGS_TTEST_IN},
};

//! Declaration for the experiment payload function in ldst-byte.S
extern void     * experiment_payload(
    uint32_t * din
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

    uint32_t * din  = (fixed ? di_fixed: di_rand);

    uas_bsp_trigger_set();
    
    experiment_payload(
        din
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "speculation/loop-0";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 6                    ;
    cfg -> randomness            = randomness;
    cfg -> randomness_len        = RLEN;
    cfg -> randomness_refresh_rate=0;

}


