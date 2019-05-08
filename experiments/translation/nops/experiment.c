
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

//! Declaration for the experiment payload function in nops.S
extern void     * experiment_payload();
extern void     * experiment_payload_end;

/*!
@details Does nothing.
*/
uint8_t experiment_init() {
    return 0;
}

/*!
@details Runs a bunch of NOPS in sequence, then finishes.
*/
uint8_t experiment_run(){

    uas_bsp_trigger_set();
    
    experiment_payload();
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){
    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;
    cfg -> experiment_name = "translation/nops";
}

