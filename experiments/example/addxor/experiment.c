
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"
#include "uas_prng.h"

#include "experiment.h"

#define EDATA_LEN 8

uint8_t           experiment_data [EDATA_LEN];

//! Declaration for the experiment payload function in nops.S
extern void     * experiment_payload(
    uint32_t a,
    uint32_t b
);

extern void     * experiment_payload_end;
    
static uint32_t prng_a;
static uint32_t prng_b;

/*!
@details Does nothing.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< PRNG / data access
) {

    for(uint8_t i = 0; i < EDATA_LEN; i++) {
        experiment_data[i] = i;
    }
    return 0;
}

/*!
@details Runs a bunch of NOPS in sequence, then finishes.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg //!< PRNG / data access
){

    prng_a = scass_prng_sample(cfg);
    prng_b = scass_prng_sample(cfg);

    uas_bsp_trigger_set();
    
    experiment_payload(prng_a, prng_b);
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){
    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;
    cfg -> experiment_name       = "example/andxor";
    cfg -> experiment_data       = experiment_data;
    cfg -> experiment_data_len   = EDATA_LEN;
}

