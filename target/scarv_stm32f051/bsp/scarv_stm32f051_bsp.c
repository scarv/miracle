
/*!
@ingroup targets-bsp
@{
@file scarv_stm32f051_bsp.c
@brief Contains BSP function definitions specific to the STM32F051 SoC
*/

#include <stdint.h>

#include "uas_bsp.h"

#include "stm32f0xx_hal_flash.h"
#include "stm32f0xx_hal_dma.h"
#include "stm32f0xx_hal_rcc.h"
#include "stm32f0xx_hal_gpio.h"
#include "stm32f0xx_hal_uart.h"

//! The UART device handle we will use
UART_HandleTypeDef UartHandle;

/*!
@brief Setup oscillators / clocking / PLLs.
*/
void init_platform() {

    RCC_OscInitTypeDef RCC_OscInitStruct = {0};
    RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

    /** Initializes the CPU, AHB and APB busses clocks
    */
    RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
    RCC_OscInitStruct.HSEState = RCC_HSE_BYPASS;
    RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
    RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
    RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL3;
    RCC_OscInitStruct.PLL.PREDIV = RCC_PREDIV_DIV1;
    HAL_RCC_OscConfig(&RCC_OscInitStruct);

    /** Initializes the CPU, AHB and APB busses clocks
    */
    RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                                |RCC_CLOCKTYPE_PCLK1;
    RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
    RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV2;
    RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
    HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_0);
    HAL_RCC_MCOConfig(RCC_MCO, RCC_MCO1SOURCE_SYSCLK, RCC_MCODIV_1);

}

/*!
@brief Setup the UART communication.
*/
void init_uart(void)
{
    GPIO_InitTypeDef GpioInit;
    GpioInit.Pin       = GPIO_PIN_2 | GPIO_PIN_3;
    GpioInit.Mode      = GPIO_MODE_AF_PP;
    GpioInit.Pull      = GPIO_PULLUP;
    GpioInit.Speed     = GPIO_SPEED_FREQ_HIGH;
    GpioInit.Alternate = GPIO_AF1_USART2;
    HAL_GPIO_Init(GPIOA, &GpioInit);

    UartHandle.Instance = USART2;
    UartHandle.Init.BaudRate = 9600;
    UartHandle.Init.WordLength = UART_WORDLENGTH_8B;
    UartHandle.Init.StopBits = UART_STOPBITS_1;
    UartHandle.Init.Parity = UART_PARITY_NONE;
    UartHandle.Init.Mode = UART_MODE_TX_RX;
    UartHandle.Init.HwFlowCtl = UART_HWCONTROL_NONE;
    UartHandle.Init.OverSampling = UART_OVERSAMPLING_16;
    UartHandle.Init.OneBitSampling = UART_ONE_BIT_SAMPLE_DISABLE;
    UartHandle.AdvancedInit.AdvFeatureInit = UART_ADVFEATURE_NO_INIT;
    HAL_UART_Init(&UartHandle);
}


void init_trigger(void)
{
    GPIO_InitTypeDef GPIO_InitStruct = {0};

    /* GPIO Ports Clock Enable */
    __HAL_RCC_GPIOF_CLK_ENABLE();
    __HAL_RCC_GPIOA_CLK_ENABLE();

    /*Configure GPIO pin Output Level */
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_0, GPIO_PIN_RESET);

    /*Configure GPIO pin : PA0 */
    GPIO_InitStruct.Pin = GPIO_PIN_0;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

    /*Configure GPIO pin : PA8 */
    GPIO_InitStruct.Pin = GPIO_PIN_8;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    GPIO_InitStruct.Alternate = GPIO_AF0_MCO;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
}

/*!
*/
uint8_t uas_bsp_init_target(){
    init_platform();
    init_trigger();
    init_uart();


    while(1){
        uas_bsp_trigger_set();
        uas_bsp_uart_wr_char('A');
        uas_bsp_trigger_clear();
    }

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
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_0, SET);
    return NULL;
}

/*!
*/
volatile void * uas_bsp_trigger_clear(){
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_0, RESET);
    return NULL;
}

//! }@
