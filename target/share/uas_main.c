
#include "uas_bsp.h"
#include "uas_control.h"

/*!
@brief The main function which runs the trigger program.
*/
int main(int argc, char ** argv) {

    // Configure the target platform
    uint8_t setup_status = uas_bsp_init_target();

    if(setup_status == 0){
    
        // Enter the control loop
        uas_ctrl_loop();

    } else {
        
        // Fail out.
        return -1;

    }

}
