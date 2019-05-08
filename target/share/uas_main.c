
#include "scass/scass_target.h"

#include "uas_bsp.h"

#include "experiment.h"

/*!
@brief The main function which runs the trigger program.
*/
int main(int argc, char ** argv) {

    // Configure the target platform
    uint8_t setup_status = uas_bsp_init_target();

    // The main configuration object for target/host communication
    scass_target_cfg scass_cfg;

    scass_cfg.scass_io_rd_char = uas_bsp_uart_rd_char;
    scass_cfg.scass_io_wr_char = uas_bsp_uart_wr_char;

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
