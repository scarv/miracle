
/*!
@ingroup experiments-example-add
@{
*/

#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

// The API which this file implements.
#include "experiment.h"

uint32_t    din_lhs_fixed; //!< Left hand argument to operation (Fixed value)
uint32_t    din_rhs_fixed; //!< Right ....
uint32_t    din_lhs      ; //!< Left hand randomised value
uint32_t    din_rhs      ; //!< Right ....
uint32_t    dout         ; //!< Result of the operation

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"lhs" , 4, &din_lhs, &din_lhs_fixed, SCASS_FLAGS_TTEST_IN},
{"rhs" , 4, &din_rhs, &din_rhs_fixed, SCASS_FLAGS_TTEST_IN},
{"dout", 4, &dout   , &dout         , SCASS_FLAG_OUTPUT   }
};

/*!
@brief Declaration for the experiment payload function in add.S
@details Adds numbers A and B, putting the result in data_out.
        Pads the prelude and exitlude to the operation with lots
        of NOPs.
*/
extern void     * experiment_payload(
    uint32_t   a,
    uint32_t   b,
    uint32_t * data_out
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

    uint32_t in_a = fixed ? din_lhs_fixed : din_lhs;
    uint32_t in_b = fixed ? din_rhs_fixed : din_rhs;

    uas_bsp_trigger_set();
    
    experiment_payload(in_a, in_b, &dout);
    
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

    cfg -> experiment_name       = "example/xor";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 2                    ;
    cfg -> randomness_len        = 0                    ;
}


//! @}
