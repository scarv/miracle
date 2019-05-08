
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
    return UAS_RSP_OKAY;
}

/*!
@brief Run the experiment once
@returns 0 if successful, non-zero otherwise.
*/
uint8_t experiment_run(){

    uas_bsp_trigger_set();
    
    experiment_payload();
    
    uas_bsp_trigger_clear();

    return UAS_RSP_OKAY;

}

