
/*!
@ingroup targets-bsp
@{
@file scarv_stm32f051_bsp.c
@brief Contains BSP function definitions specific to the STM32F051 SoC
*/

#include <stdint.h>

#include "uas_bsp.h"

#include "stm32f0xx_hal.h"
#include "stm32f0xx_hal_flash.h"
#include "stm32f0xx_hal_dma.h"
#include "stm32f0xx_hal_rcc.h"
#include "stm32f0xx_hal_gpio.h"
#include "stm32f0xx_hal_uart.h"

//! The UART device handle we will use
UART_HandleTypeDef huart2;

/*!
@brief Setup oscillators / clocking / PLLs.
*/
void init_platform() {
    HAL_Init();

    RCC_OscInitTypeDef RCC_OscInitStruct = {0};
    RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

    /** Initializes the CPU, AHB and APB busses clocks
    */
    RCC_OscInitStruct.OscillatorType    = RCC_OSCILLATORTYPE_HSE;
    RCC_OscInitStruct.HSEState          = RCC_HSE_BYPASS;
    RCC_OscInitStruct.PLL.PLLState      = RCC_PLL_OFF;
    RCC_OscInitStruct.PLL.PLLSource     = RCC_PLLSOURCE_HSE;
    RCC_OscInitStruct.PLL.PLLMUL        = RCC_PLL_MUL3;
    RCC_OscInitStruct.PLL.PREDIV        = RCC_PREDIV_DIV1;
    if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
    {
      //Error_Handler();
    }
    /** Initializes the CPU, AHB and APB busses clocks
    */
    RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                                |RCC_CLOCKTYPE_PCLK1;
    RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_HSE;
    RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
    RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;

    if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_0) != HAL_OK)
    {
      //Error_Handler();
    }
    HAL_RCC_MCOConfig(RCC_MCO, RCC_MCO1SOURCE_SYSCLK, RCC_MCODIV_1);
}

/*!
@brief Setup the UART communication.
*/
void init_uart(void)
{
    GPIO_InitTypeDef GPIO_InitStruct = {0};
    __HAL_RCC_USART2_CLK_ENABLE();
    __HAL_RCC_GPIOA_CLK_ENABLE();
    /**USART2 GPIO Configuration
    PA2     ------> USART2_TX
    PA3     ------> USART2_RX
    */
    GPIO_InitStruct.Pin = GPIO_PIN_2|GPIO_PIN_3;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    GPIO_InitStruct.Alternate = GPIO_AF1_USART2;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

    huart2.Instance = USART2;
    huart2.Init.BaudRate = 115200;
    huart2.Init.WordLength = UART_WORDLENGTH_8B;
    huart2.Init.StopBits = UART_STOPBITS_1;
    huart2.Init.Parity = UART_PARITY_NONE;
    huart2.Init.Mode = UART_MODE_TX_RX;
    huart2.Init.HwFlowCtl = UART_HWCONTROL_NONE;
    huart2.Init.OverSampling = UART_OVERSAMPLING_16;
    huart2.Init.OneBitSampling = UART_ONE_BIT_SAMPLE_DISABLE;
    huart2.AdvancedInit.AdvFeatureInit = UART_ADVFEATURE_NO_INIT;
    if (HAL_UART_Init(&huart2) != HAL_OK)
    {
      //Error_Handler();
    }
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
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

    /*Configure GPIO pin : PA8 */
    GPIO_InitStruct.Pin = GPIO_PIN_8;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    GPIO_InitStruct.Alternate = GPIO_AF0_MCO;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
}

/*!
*/
uint8_t uas_bsp_init_target(){
    // Disable interrupts
    __disable_irq();

    init_platform();
    init_trigger();
    init_uart();

    return 0;
}

/*!
*/
uint8_t uas_bsp_uart_rd_char(){
    uint8_t d;
    while(HAL_UART_Receive(&huart2, &d, 1, 500000) != HAL_OK);
    return d;
}

/*!
*/
void    uas_bsp_uart_wr_char(
    uint8_t tosend
){
    HAL_UART_Transmit(&huart2,  &tosend, 1, 500000);
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

void NMI_Handler(){while(1){}}
void HardFault_Handler(){while(1){}}
void SVC_Handler(){while(1){}}
void PendSV_Handler(){while(1){}}
void SysTick_Handler(){while(1){}}
void WWDG_IRQHandler(){while(1){}}
void PVD_IRQHandler(){while(1){}}
void RTC_IRQHandler(){while(1){}}
void FLASH_IRQHandler(){while(1){}}
void RCC_CRS_IRQHandler(){while(1){}}
void EXTI0_1_IRQHandler(){while(1){}}
void EXTI2_3_IRQHandler(){while(1){}}
void EXTI4_15_IRQHandler(){while(1){}}
void TSC_IRQHandler(){while(1){}}
void DMA1_Channel1_IRQHandler(){while(1){}}
void DMA1_Channel2_3_IRQHandler(){while(1){}}
void DMA1_Channel4_5_IRQHandler(){while(1){}}
void ADC1_COMP_IRQHandler(){while(1){}}
void TIM1_BRK_UP_TRG_COM_IRQHandler(){while(1){}}
void TIM1_CC_IRQHandler(){while(1){}}
void TIM2_IRQHandler(){while(1){}}
void TIM3_IRQHandler(){while(1){}}
void TIM6_DAC_IRQHandler(){while(1){}}
void TIM14_IRQHandler(){while(1){}}
void TIM15_IRQHandler(){while(1){}}
void TIM16_IRQHandler(){while(1){}}
void TIM17_IRQHandler(){while(1){}}
void I2C1_IRQHandler(){while(1){}}
void I2C2_IRQHandler(){while(1){}}
void SPI1_IRQHandler(){while(1){}}
void SPI2_IRQHandler(){while(1){}}
void USART1_IRQHandler(){while(1){}}
void USART2_IRQHandler(){while(1){}}
void CEC_CAN_IRQHandler(){while(1){}}
//! }@
