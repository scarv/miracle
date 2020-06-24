
/*!
@ingroup targets-bsp
@{
*/

#include <stdlib.h>

#include "scass/scass_target.h"

#include "uas_bsp.h"

#include "experiment.h"

//! Default value clock rates: 0 is just the default.
uint32_t scass_default_clk_rates[1] = {0};

//! Default set clock rate function. Does nothing.
static void scass_default_set_clk_rate(
    uint32_t                rate    ,
    scass_clk_src_t         src     ,
    scass_target_clk_info * clk_cfg
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
    scass_cfg.sys_clk.clk_rates = scass_default_clk_rates;
    scass_cfg.sys_clk.clk_rates_num     = 1;
    scass_cfg.sys_clk.clk_current       = 0;
    scass_cfg.sys_clk.ext_clk_rate      = 0;
    scass_cfg.sys_clk.clk_source_current= SCASS_CLK_SRC_INTERNAL ;
    scass_cfg.sys_clk.clk_source_avail  = SCASS_CLK_SRC_INTERNAL |
                                          SCASS_CLK_SRC_EXTERNAL |
                                          SCASS_CLK_SRC_PLL      ;
    scass_cfg.sys_clk.sys_set_clk_rate  = scass_default_set_clk_rate;

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
