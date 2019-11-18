
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#define DLEN 8
#ifndef DOFF
    #define DOFF 0
#endif

uint8_t  din_fixed [DLEN];
uint8_t  din_rand  [DLEN];

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"din" , 1, din_rand+DOFF, din_fixed+DOFF, SCASS_FLAGS_TTEST_IN},
};

//! Declaration for the experiment payload function in load-byte.S
extern void     * experiment_payload(
    uint8_t * data,
);

extern void     * experiment_payload_end;

/*!
@details Does nothing.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< SCASS Framework configuration object.
) {
    for(int i = 0; i < DLEN; i ++) {
        din_fixed[i] = 0;
        din_rand [i] = 0;
    }
    return 0;
}

/*!
@details Runs the experiment, then finishes.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg,  //!< SCASS Framework configuration object.
    char               fixed //!< used fixed variants of variables?
){

    uint8_t * data_in = fixed ? din_fixed : din_rand;

    uas_bsp_trigger_set();
    
    experiment_payload(
        data_in,
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "memory/bus-width-" XSTR(DOFF);

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 2                    ;
    cfg -> randomness_len        = 0                    ;

}

