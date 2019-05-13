
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"
#include "uas_prng.h"

#include "experiment.h"

#define EDATA_IN_LEN 8
#define EDATA_OUT_LEN 4

uint8_t           data_in  [EDATA_IN_LEN ];
uint8_t           data_out [EDATA_OUT_LEN];

//! Declaration for the experiment payload function in nops.S
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

    uint32_t in_a = ((uint32_t*)data_in)[0];
    uint32_t in_b = ((uint32_t*)data_in)[1];

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

    cfg -> experiment_name       = "example/andxor";

    cfg -> data_in               = data_in;
    cfg -> data_in_len           = EDATA_IN_LEN;

    cfg -> data_out              = data_out;
    cfg -> data_out_len          = EDATA_OUT_LEN;

}

