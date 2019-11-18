
/*!
@ingroup experiments-example-add
@{
*/

#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

// The API which this file implements.
#include "experiment.h"

static uint32_t din_fixed; //!< argument to operation (Fixed value)
static uint32_t din_rand ; //!< ..       ..  ..       (randomised value)

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"din" , 4, &din_rand, &din_fixed, SCASS_FLAGS_TTEST_IN}
};

/*!
@brief Declaration for the experiment payload function in ld_byte.S
@details Adds numbers A and B, putting the result in data_out.
        Pads the prelude and exitlude to the operation with lots
        of NOPs.
*/
extern void     * experiment_payload(
    uint32_t * d_in
);

//! Symbol occuring immediately at the end of the experiment payload code.
extern void     * experiment_payload_end;


/*!
@brief Perform any one-time setup needed by the experiment.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< SCASS Framework configuration object.
) {
    return 0;
}


/*!
@brief Runs a single instance of the experiment
@details Pulls input data from the SCASS framework, runs the
    experiment code and returns. Responsible for setting and clearing
    the trigger signal.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg,  //!< SCASS Framework configuration object.
    char               fixed //!< used fixed variants of variables?
){

    uint32_t * d_in = fixed ? &din_fixed : &din_rand;

    uas_bsp_trigger_set();
    
    experiment_payload(d_in);
    
    uas_bsp_trigger_clear();

    return 0;

}


/*!
@brief Sets up the SCASS framework config object.
*/
void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "example/ld-byte";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 1                    ;
    cfg -> randomness_len        = 0                    ;
}


//! @}
