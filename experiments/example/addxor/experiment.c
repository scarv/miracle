
#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

uint32_t    din_lhs_fixed;
uint32_t    din_rhs_fixed;
uint32_t    din_lhs;
uint32_t    din_rhs;
uint32_t    dout   ;

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"lhs" , 4, &din_lhs, &din_lhs_fixed, SCASS_FLAGS_TTEST_IN},
{"rhs" , 4, &din_rhs, &din_rhs_fixed, SCASS_FLAGS_TTEST_IN},
{"dout", 4, &dout   , &dout         , SCASS_FLAG_OUTPUT   }
};

//! Declaration for the experiment payload function in add.S
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
    return 0;
}

/*!
@details Runs a bunch of NOPS in sequence, then finishes.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg, //!< PRNG / data access
    char               fixed //!< used fixed variants of variables?
){

    uint32_t in_a = fixed ? din_lhs_fixed : din_lhs;
    uint32_t in_b = fixed ? din_rhs_fixed : din_rhs;

    uas_bsp_trigger_set();
    
    experiment_payload(in_a, in_b, &dout);
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "example/andxor";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 2                    ;
    cfg -> randomness_len        = 0                    ;

}

