
/*!
@ingroup targets-bsp
@{
*/

#include <stdlib.h>

#include "scass/scass_target.h"

#include "uas_bsp.h"

#include "experiment.h"

//! Default clock information for every device. Populated in uas_bsp_init_target.
scass_target_clk_info default_clk_info;

//! Default set clock rate function. Does nothing.
static void scass_default_set_clk_rate(
    uint8_t               new_clk_cfg,
    scass_target_cfg    * cfg
) {
    return;
}

/*!
@brief The main function which runs the trigger program.
*/
int main(int argc, char ** argv) {

    // The main configuration object for target/host communication
    scass_target_cfg scass_cfg;

    scass_cfg.scass_experiment_pre_run  = NULL;
    scass_cfg.scass_experiment_post_run = NULL;

    scass_cfg.experiment_cycles         = 0;
    scass_cfg.experiment_instrret       = 0;

    scass_cfg.randomness                = NULL;
    scass_cfg.randomness_len            = 0;
    scass_cfg.randomness_refresh_rate   = 0;
    scass_cfg.num_variables             = 0;

    scass_cfg.scass_io_rd_char = uas_bsp_uart_rd_char;
    scass_cfg.scass_io_wr_char = uas_bsp_uart_wr_char;

    // Default system clock configuration
    scass_cfg.num_clk_cfgs              = 1;
    scass_cfg.current_clk_cfg           = 0;
    scass_cfg.clk_cfgs                  = &default_clk_info;
    scass_cfg.sys_set_clk_rate          = scass_default_set_clk_rate;

    // Configure the target platform
    uint8_t setup_status = uas_bsp_init_target(&scass_cfg);

    // Configure the scass config object before entering the main loop.
    experiment_setup_scass(&scass_cfg);

    if(setup_status == 0){
    
        // Enter the control loop
        scass_loop(&scass_cfg);

    } else {
        
        // Fail out.
        return -1;

    }

}
//! }@
