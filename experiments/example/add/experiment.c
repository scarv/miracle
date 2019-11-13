
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#define EDATA_IN_LEN 8
#define EDATA_OUT_LEN 4

uint8_t           data_in  [EDATA_IN_LEN ];
uint8_t           data_out [EDATA_OUT_LEN];

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"data_in" , EDATA_IN_LEN , data_in , SCASS_FLAGS_TTEST_IN},
{"data_out", EDATA_OUT_LEN, data_out, SCASS_FLAG_OUTPUT   }
};

//! Declaration for the experiment payload function in add.S
extern void     * experiment_payload(
    uint32_t   a,
    uint32_t   b,
    uint32_t * data_out
);

extern void     * experiment_payload_end;

/*!
@details Does nothing.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< PRNG / data access
) {

    for(uint8_t i = 0; i < EDATA_IN_LEN; i++) {
        data_in[i] = i;
    }
    for(uint8_t i = 0; i < EDATA_OUT_LEN; i++) {
        data_out[i] = i;
    }
    return 0;
}

/*!
@details Runs a bunch of NOPS in sequence, then finishes.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg //!< PRNG / data access
){

    uint32_t in_a = data_in[0];
    uint32_t in_b = data_in[1];

    uas_bsp_trigger_set();
    
    experiment_payload(in_a, in_b, (uint32_t*)data_out);
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "example/add";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 2                    ;
    cfg -> randomness_len        = 0                    ;
}

