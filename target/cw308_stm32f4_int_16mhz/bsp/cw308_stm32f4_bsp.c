
/*!
@ingroup targets-bsp
@{
@file cw308_stm32f4_bsp.c
@brief Contains BSP function definitions specific to the STM32F0 SoC
*/

#include <stdint.h>

#include "uas_bsp.h"

#include "stm32f4xx_hal_flash.h"
#include "stm32f4xx_hal_dma.h"
#include "stm32f4xx_hal_rcc.h"
#include "stm32f4xx_hal_gpio.h"
#include "stm32f4xx_hal_uart.h"

UART_HandleTypeDef UartHandle;

//! Default set clock rate function. Does nothing.
static void stm32f_set_clk_rate(
    uint8_t               new_clk_cfg,
    scass_target_cfg    * cfg
) {

    // Setup the clock source.
	RCC_OscInitTypeDef RCC_OscInitStruct;
	RCC_ClkInitTypeDef RCC_ClkInitStruct;
    
    if(new_clk_cfg == 0) {
        
        RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
        RCC_OscInitStruct.HSIState = RCC_HSI_ON;
        RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
        RCC_OscInitStruct.PLL.PLLState = RCC_PLL_NONE;
        HAL_RCC_OscConfig(&RCC_OscInitStruct);
        /** Initializes the CPU, AHB and APB busses clocks
        */
        RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                                    |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
        RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_HSI;
        RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
        RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;
        RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;

        HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_0);

    } else {
        
        // Fail.
        return;

    }

    cfg -> current_clk_cfg = new_clk_cfg;
}

/*!
@brief Setup the UART communication.
*/
void init_uart(void)
{
    GPIO_InitTypeDef GpioInit;
	GpioInit.Pin       = GPIO_PIN_9 | GPIO_PIN_10;
	GpioInit.Mode      = GPIO_MODE_AF_PP;
	GpioInit.Pull      = GPIO_PULLUP;
	GpioInit.Speed     = GPIO_SPEED_FREQ_HIGH;
	GpioInit.Alternate = GPIO_AF7_USART1;
	__GPIOA_CLK_ENABLE();
	__GPIOA_CLK_ENABLE();
	HAL_GPIO_Init(GPIOA, &GpioInit);

    UartHandle.Instance = USART1;
    UartHandle.Init.BaudRate = 115200;
    UartHandle.Init.WordLength = UART_WORDLENGTH_8B;
    UartHandle.Init.StopBits = UART_STOPBITS_1;
    UartHandle.Init.Parity = UART_PARITY_NONE;
    UartHandle.Init.Mode = UART_MODE_TX_RX;
    UartHandle.Init.HwFlowCtl = UART_HWCONTROL_NONE;
    UartHandle.Init.OverSampling = UART_OVERSAMPLING_16;
	__USART1_CLK_ENABLE();
	HAL_UART_Init(&UartHandle);
}


void init_trigger(void)
{
    GPIO_InitTypeDef GpioInit;
	GpioInit.Pin       = GPIO_PIN_12;
	GpioInit.Mode      = GPIO_MODE_OUTPUT_PP;
	GpioInit.Pull      = GPIO_NOPULL;
	GpioInit.Speed     = GPIO_SPEED_FREQ_HIGH;
	HAL_GPIO_Init(GPIOA, &GpioInit);
}

/*!
*/
uint8_t uas_bsp_init_target(
    scass_target_cfg * cfg //!< The scass target object to configure.
){

    // Set the current clock rate.
    cfg -> clk_cfgs[0].sys_clk_rate     = 16000000;
    cfg -> clk_cfgs[0].sys_clk_src      = SCASS_CLK_SRC_INTERNAL;

    stm32f_set_clk_rate(0, cfg);
    init_uart();
    init_trigger();

    uas_bsp_trigger_set();
    uas_bsp_trigger_clear();

    return 0;
}

/*!
*/
uint8_t uas_bsp_uart_rd_char(){
    uint8_t d;
    while(HAL_UART_Receive(&UartHandle, &d, 1, 500000) != HAL_OK);
    return d;
}

/*!
*/
void    uas_bsp_uart_wr_char(
    uint8_t tosend
){
    HAL_UART_Transmit(&UartHandle,  &tosend, 1, 500000);
}


/*!
*/
volatile void * uas_bsp_trigger_set(){
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_12, SET);
    return NULL;
}

/*!
*/
volatile void * uas_bsp_trigger_clear(){
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_12, RESET);
    return NULL;
}

//! }@

