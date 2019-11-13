
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#define EDATA_IN_LEN 8
#define EDATA_OUT_LEN 4

// An address in FLASH / non-default memory device
volatile uint8_t * data_mem2 = 
#if TARGET == 3
    // ARM M3 target SCALE_LPC1313FBD48
    (volatile uint8_t*)(0x10006F00);
#elif TARGET == 2
    // ARM M0 target SCALE_LPC1114FN28
    (volatile uint8_t*)(0x10001F00);
#elif TARGET == 1
    // ARM M0+ target SCALE_LPC812M101
    (volatile uint8_t*)(0x10000F00);
#else
    // SAKURAX platforms
    (volatile uint8_t*)(0x10000a00);
#endif

uint8_t   data_in  [EDATA_IN_LEN ];
uint8_t   data_out [EDATA_OUT_LEN];

//! Declaration for the experiment payload function in lb_0.S
extern void     * experiment_payload(
    uint8_t * data_flash,
    volatile uint8_t * data_mem2  
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
        data_mem2[i] = i;
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
        data_mem2[i] = data_in[i];
    }

    uas_bsp_trigger_set();
    
    experiment_payload(
        data_in,
        data_mem2
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

    cfg -> data_in               = data_in;
    cfg -> data_in_len           = EDATA_IN_LEN;

    cfg -> data_out              = data_out;
    cfg -> data_out_len          = EDATA_OUT_LEN;

}

