
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
volatile uint8_t darry_fixed [DLEN];
volatile uint8_t darry_rand  [DLEN];
volatile uint8_t outarry     [DLEN];

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"d0" , 1, darry_rand+0, darry_fixed+0, SCASS_FLAGS_TTEST_IN},
{"d1" , 1, darry_rand+1, darry_fixed+1, SCASS_FLAGS_TTEST_IN},
{"d2" , 1, darry_rand+2, darry_fixed+2, SCASS_FLAGS_TTEST_IN}
};

//! Declaration for the experiment payload function in arch/*.S
extern void     * experiment_payload(
    volatile uint8_t * out,
    uint8_t d0,
    uint8_t d1,
    uint8_t d2
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

    volatile uint8_t * din = fixed ? darry_fixed : darry_rand;
    uint8_t d0 = din[0];
    uint8_t d1 = din[1];
    uint8_t d2 = din[2];

    for(int i = 0; i < DLEN; i ++) {
        outarry[i] = 0;
    }

    uas_bsp_trigger_set();
    
    experiment_payload(
        outarry,
        d0,
        d1,
        d2
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "memory-bus/seq-st-bytes";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 3                    ;
    cfg -> randomness_len        = 0                    ;

}

//! @}

