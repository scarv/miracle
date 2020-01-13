CFLAGS += -DTARGET=11
CFLAGS += -DARCH_ARMV7M -Wall -mcpu=cortex-m3 -mthumb -O2
CFLAGS += -mfloat-abi=soft -ffunction-sections -Wl,--gc-sections -lm
CFLAGS += -T $(UAS_ROOT)/target/cw308_stm32f2/build/linker.ld
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f2/bsp/CMSIS/core
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f2/bsp/CMSIS/device
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f2/bsp
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f2/bsp/stm32f2
CFLAGS += -DSTM32F215xx -DSTM32F2 -DSTM32 -DDEBUG

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

TARGET_SRCS =$(UAS_ROOT)/target/cw308_stm32f2/bsp/cw308_stm32f2_bsp.c \
             $(UAS_ROOT)/target/cw308_stm32f2/bsp/cw308_stm32f2_startup.S \
             $(UAS_ROOT)/target/cw308_stm32f2/bsp/stm32f2_hal_lowlevel.c

