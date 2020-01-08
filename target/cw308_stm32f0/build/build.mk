CFLAGS += -DTARGET=9
CFLAGS += -DARCH_ARMV6M -Wall -march=armv6-m -mcpu=cortex-m0 -mthumb -O2
CFLAGS += -mfloat-abi=soft -ffunction-sections -Wl,--gc-sections -lm
CFLAGS += -T $(UAS_ROOT)/target/cw308_stm32f0/build/linker.ld
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f0/bsp/CMSIS/core
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f0/bsp/CMSIS/device
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f0/bsp
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f0/bsp/stm32f0
CFLAGS += -DSTM32F071xB -DSTM32F071RBTX -DSTM32F0 -DSTM32 -DDEBUG

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

TARGET_SRCS =$(UAS_ROOT)/target/cw308_stm32f0/bsp/cw308_stm32f0_bsp.c \
             $(UAS_ROOT)/target/cw308_stm32f0/bsp/cw308_stm32f0_startup.S \
             $(UAS_ROOT)/target/cw308_stm32f0/bsp/stm32f0_hal_lowlevel.c

