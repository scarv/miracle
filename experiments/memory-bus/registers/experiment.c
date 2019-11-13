
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#define EDATA_IN_LEN  16
#define EDATA_OUT_LEN 4

// An address in SRAM
volatile uint8_t * data_sram = (volatile uint8_t*)(0x10000a00);

uint8_t   data_in  [EDATA_IN_LEN ];
uint8_t   data_out [EDATA_OUT_LEN];

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"data_in" , EDATA_IN_LEN , data_in , SCASS_FLAGS_TTEST_IN},
{"data_out", EDATA_OUT_LEN, data_out, SCASS_FLAG_OUTPUT   }
};

//! Declaration for the experiment payload function in experiment.S
extern void     * experiment_payload(
    volatile uint8_t * data_in,  
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

    for(int i = 0; i < EDATA_IN_LEN; i ++) {
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

    cfg -> experiment_name       = "memory/registers";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 2                    ;
    cfg -> randomness_len        = 0                    ;

}

