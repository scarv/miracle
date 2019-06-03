
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"
#include "uas_prng.h"

#include "experiment.h"

#define EDATA_IN_LEN  32
#define EDATA_OUT_LEN 16

uint8_t   data_in  [EDATA_IN_LEN ];
uint8_t   data_out [EDATA_OUT_LEN];

uint8_t   sbox[256];

//! Declaration for the experiment payload function in lb_0.S
extern void     * experiment_payload(
    uint8_t * data_in ,
    uint8_t * rnd_key ,
    uint8_t * sbox
);

extern void     * experiment_payload_end;

/*!
@details Does nothing.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< PRNG / data access
) {
    return 0;
}

/*!
@details Runs the experiment, then finishes.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg //!< PRNG / data access
){

    uint8_t * d_in = &data_in[ 0];
    uint8_t * key  = &data_in[16];

    uas_bsp_trigger_set();
    
    experiment_payload(
        d_in,
        key,
        sbox
    );
    
    uas_bsp_trigger_clear();

    for(int i =0; i < 16; i ++) {
        data_out[i] = data_in[i];
    }

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "memory/aes-sbox";

    cfg -> data_in               = data_in;
    cfg -> data_in_len           = EDATA_IN_LEN;

    cfg -> data_out              = data_out;
    cfg -> data_out_len          = EDATA_OUT_LEN;

}

