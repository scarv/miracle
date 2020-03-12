TARGET_ARCH=ARMV6M
CFLAGS += -DTARGET=17
CFLAGS += -DARCH_$(TARGET_ARCH) -Wall -march=armv6-m -mcpu=cortex-m0 -mthumb -O2
CFLAGS += -mfloat-abi=soft -ffunction-sections -Wl,--gc-sections -lm
CFLAGS += -T $(UAS_ROOT)/target/scarv_stm32f051/build/linker.ld
CFLAGS += -I $(UAS_ROOT)/target/scarv_stm32f051/bsp/stm32f0xx/CMSIS/core
CFLAGS += -I $(UAS_ROOT)/target/scarv_stm32f051/bsp/stm32f0xx/CMSIS/device
CFLAGS += -I $(UAS_ROOT)/target/scarv_stm32f051/bsp/stm32f0xx/driver/include
CFLAGS += -DSTM32F051x8 -DSTM32F051C8 -DSTM32F0 -DSTM32 -DDEBUG

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

SRC_ROOT=$(UAS_ROOT)/target/scarv_stm32f051/bsp

TARGET_SRCS =\
    $(SRC_ROOT)/system_stm32f0xx.c \
    $(SRC_ROOT)/startup_stm32f051x8.s \
    $(SRC_ROOT)/scarv_stm32f051_bsp.c \
    $(SRC_ROOT)/stm32f0xx/driver/src/stm32f0xx_hal.c \
    $(SRC_ROOT)/stm32f0xx/driver/src/stm32f0xx_hal_rcc.c \
    $(SRC_ROOT)/stm32f0xx/driver/src/stm32f0xx_hal_rcc_ex.c \
    $(SRC_ROOT)/stm32f0xx/driver/src/stm32f0xx_hal_gpio.c \
    $(SRC_ROOT)/stm32f0xx/driver/src/stm32f0xx_hal_uart.c \
    $(SRC_ROOT)/stm32f0xx/driver/src/stm32f0xx_hal_uart_ex.c \
    $(SRC_ROOT)/stm32f0xx/driver/src/stm32f0xx_hal_cortex.c
