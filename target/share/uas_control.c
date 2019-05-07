
#include "uas_bsp.h"
#include "uas_prng.h"

#include "uas_control.h"

#include "experiment.h"

/*!
@brief Read 4 bytes from the UART and use them to seed the PRNG.
@details Reads the most significant byte of the 32-bit seed value first.
@returns 0 on success, non-zero on failure.
*/
static uint8_t seed_prng() {
    
    uint32_t seed = (uas_bsp_uart_rd_char() << 24) |
                    (uas_bsp_uart_rd_char() << 16) |
                    (uas_bsp_uart_rd_char() <<  8) |
                    (uas_bsp_uart_rd_char() <<  0) ;
    
    uas_prng_seed(seed);

    return 0;

}


void uas_ctrl_loop() {

    while(1) {

        uint8_t cmd = uas_bsp_uart_rd_char();
        uint8_t rsp = UAS_RSP_ERROR;

        switch(cmd) {
            case UAS_CMD_HELLOWORLD:
                uas_bsp_uart_wr_str("Hello World!\n");
                rsp = UAS_RSP_OKAY;
                break;

            case UAS_CMD_INIT_EXPERIMENT:
                rsp = experiment_init();
                break;

            case UAS_CMD_RUN_EXPERIMENT:
                rsp = experiment_run();
                break;

            case UAS_CMD_SEED_PRNG:
                rsp = seed_prng() ? UAS_RSP_ERROR : UAS_RSP_OKAY;
                break;

            default:
                break;
        }
        
        uas_bsp_uart_wr_char(rsp);

    }

}

