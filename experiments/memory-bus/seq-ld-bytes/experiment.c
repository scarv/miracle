
/*!
@ingroup experiments-memory-bus-width-ld-bytes
@{
*/

#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#ifndef DLEN
    #define DLEN 8
#endif

uint64_t temp;
uint8_t darry_fixed [8];
uint8_t darry_rand  [8];

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"d0" , 1, darry_rand+0, darry_fixed+0, SCASS_FLAGS_TTEST_IN},
{"d1" , 1, darry_rand+1, darry_fixed+1, SCASS_FLAGS_TTEST_IN},
{"d2" , 1, darry_rand+2, darry_fixed+2, SCASS_FLAGS_TTEST_IN},
{"d3" , 1, darry_rand+3, darry_fixed+3, SCASS_FLAGS_TTEST_IN},
{"d4" , 1, darry_rand+4, darry_fixed+4, SCASS_FLAGS_TTEST_IN},
{"d5" , 1, darry_rand+5, darry_fixed+5, SCASS_FLAGS_TTEST_IN},
{"d6" , 1, darry_rand+6, darry_fixed+6, SCASS_FLAGS_TTEST_IN},
{"d7" , 1, darry_rand+7, darry_fixed+7, SCASS_FLAGS_TTEST_IN}
};

//! Declaration for the experiment payload function in arch/*.S
extern void     * experiment_payload(
    uint8_t * data
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

    uint8_t * din = fixed ? darry_fixed : darry_rand;

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

    cfg -> experiment_name       = "memory-bus/seq-ld-bytes";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 8                    ;
    cfg -> randomness_len        = 0                    ;

}

//! @}

