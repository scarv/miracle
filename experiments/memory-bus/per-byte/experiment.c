
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"
#include "uas_prng.h"

#include "experiment.h"

#define EDATA_IN_LEN 8
#define EDATA_OUT_LEN 4

// An address in SRAM
volatile uint8_t * data_sram = (volatile uint8_t*)(0x10000800);

uint8_t   data_in  [EDATA_IN_LEN ];
uint8_t   data_out [EDATA_OUT_LEN];

//! Declaration for the experiment payload function in lb_0.S
extern void     * experiment_payload(
    uint8_t * data_flash,
    volatile uint8_t * data_sram  
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
        data_sram[i] = i;
    }
    for(uint8_t i = 0; i < EDATA_OUT_LEN; i++) {
        data_out[i] = i;
    }
    return 0;
}

/*!
@details Runs the experiment, then finishes.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg //!< PRNG / data access
){
    
    for(int i = 0; i < 8; i ++) {
        data_sram[i] = data_in[i];
    }

    uas_bsp_trigger_set();
    
    experiment_payload(
        data_in,
        data_sram
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "memory/lb_0";

    cfg -> data_in               = data_in;
    cfg -> data_in_len           = EDATA_IN_LEN;

    cfg -> data_out              = data_out;
    cfg -> data_out_len          = EDATA_OUT_LEN;

}

