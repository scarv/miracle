TARGET_ARCH=ARMV6M
CFLAGS += -DTARGET=17
CFLAGS += -DARCH_$(TARGET_ARCH) -Wall -march=armv6-m -mcpu=cortex-m0 -mthumb -O2
CFLAGS += -mfloat-abi=soft -ffunction-sections -Wl,--gc-sections -lm
CFLAGS += -T $(UAS_ROOT)/target/scarv_stm32f051/build/linker.ld
CFLAGS += -I $(UAS_ROOT)/target/scarv_stm32f051/bsp/CMSIS/core
CFLAGS += -I $(UAS_ROOT)/target/scarv_stm32f051/bsp/CMSIS/device
CFLAGS += -I $(UAS_ROOT)/target/scarv_stm32f051/bsp
CFLAGS += -I $(UAS_ROOT)/target/scarv_stm32f051/bsp/stm32f0
CFLAGS += -DSTM32F051x8 -DSTM32F051C8 -DSTM32F0 -DSTM32 -DDEBUG

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

TARGET_SRCS =\
    $(UAS_ROOT)/target/scarv_stm32f051/bsp/system_stm32f0xx.c \
    $(UAS_ROOT)/target/scarv_stm32f051/bsp/scarv_stm32f051_hal_lowlevel.c \
    $(UAS_ROOT)/target/scarv_stm32f051/bsp/scarv_stm32f051_startup.S \
    $(UAS_ROOT)/target/scarv_stm32f051/bsp/scarv_stm32f051_bsp.c
