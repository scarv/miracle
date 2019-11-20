
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#ifndef DLEN
    #define DLEN 128
#endif

uint8_t  zeros     [DLEN];
uint8_t  din_fixed       ;
uint8_t  din_rand        ;
uint8_t  din       [DLEN];
uint8_t  dindex          ;
uint8_t  doffset         ;

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"din" , 1, &din_rand, &din_fixed, SCASS_FLAGS_TTEST_IN},
{"idx" , 1, &dindex  , &dindex   , SCASS_FLAG_INPUT    },
{"off" , 1, &doffset , &doffset  , SCASS_FLAG_INPUT    }
};

//! Declaration for the experiment payload function in load-byte.S
extern void     * experiment_payload(
    uint8_t * zeros,
    uint8_t * data
);

extern void     * experiment_payload_end;

/*!
@details Does nothing.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< SCASS Framework configuration object.
) {
    for(int i = 0; i < DLEN; i ++) {
        din  [i] = 0;
        zeros[i] = 0;
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

    din[dindex] = fixed ? din_fixed : din_rand;

    uas_bsp_trigger_set();
    
    experiment_payload(
        zeros,
        &din[doffset]
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "memory/bus-width";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 3                    ;
    cfg -> randomness_len        = 0                    ;

}

