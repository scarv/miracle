
/*!
@defgroup experiments-memory-registers-implicit-st-ld-code Experiment Code
@{
@ingroup experiments-memory-registers-implicit-st-ld
*/

#include <stdlib.h>
#include <string.h>

#include "uas_bsp.h"

#include "experiment.h"

#ifndef DLEN
    #define DLEN 32
#endif

#define RLEN 1

uint32_t  zeros     [DLEN]; //!< TTest fixed input value.
uint32_t  di1_fixed,di1_rand ; //!< TTest random input values.
uint32_t  di2_fixed,di2_rand ; //!< TTest random input values.
uint32_t  din       [DLEN]; //!< Array of zeros except for TTest variable.
uint8_t  dindex1         ; //!< Index into DIN to load/modify.
uint8_t  dindex2         ; //!< Offset of DIN to load during experiment_run

uint8_t  randomness[RLEN]; //!< Array of random bytes managed by SCASS.

//! Variables which the SCASS framework can control.
scass_target_var  experiment_variables [] = {
{"di1" , 4, &di1_rand, &di1_fixed, SCASS_FLAGS_TTEST_IN},
{"di2" , 4, &di2_rand, &di2_fixed, SCASS_FLAGS_TTEST_IN},
{"idx1", 1, &dindex1 , &dindex1  , SCASS_FLAG_INPUT    },
{"idx2", 1, &dindex2 , &dindex2  , SCASS_FLAG_INPUT    },
};

//! Declaration for the experiment payload function in ldst-byte.S
extern void     * experiment_payload(
    uint32_t * zeros,
    uint32_t * data1,
    uint32_t * data2,
    uint32_t   di2
);

/*!
@details Does nothing.
*/
uint8_t experiment_init(
    scass_target_cfg * cfg //!< SCASS Framework configuration object.
) {
    for(int i = 0; i < DLEN; i ++) {
        din  [i] = 0;
    }
    return 0;
}

    
/*!
@brief Automatically called before every experiment run.
@param cfg - The scass_target_cfg object associated with the experiment.
@param fixed - Use fixed variants of each variable
@returns 0 on success, non-zero on failure.
@details Clears the din array to zeros.
*/
uint8_t experiment_pre_run(
    scass_target_cfg * cfg,
    char               fixed
){
    for(int i = 0; i < DLEN; i ++) {
        din  [i] = 0;
    }
    return 0;
}


/*!
@details Runs the experiment, then finishes.
*/
uint8_t experiment_run(
    scass_target_cfg * cfg,  //!< SCASS Framework configuration object.
    char               fixed //!< used fixed variants of variables?
){

    din[dindex1] = (fixed ? di1_fixed: di1_rand);
    din[dindex2] = 0;
    uint32_t  di2= (fixed ? di2_fixed: di2_rand);

    uas_bsp_trigger_set();
    
    experiment_payload(
        zeros,
        &din[dindex1],
        &din[dindex2],
        di2
    );
    
    uas_bsp_trigger_clear();

    return 0;

}

void experiment_setup_scass(
    scass_target_cfg * cfg //!< The config object to setup.
){

    cfg -> scass_experiment_init = experiment_init;
    cfg -> scass_experiment_pre_run  = experiment_pre_run ;
    cfg -> scass_experiment_run  = experiment_run ;

    cfg -> experiment_name       = "memory-bus/registers-implicit-st-ld";

    cfg -> variables             = experiment_variables ;
    cfg -> num_variables         = 4                    ;
    cfg -> randomness            = randomness;
    cfg -> randomness_len        = 0;
    cfg -> randomness_refresh_rate = 0;

}

//! @}

