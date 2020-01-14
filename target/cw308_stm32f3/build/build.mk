CFLAGS += -DTARGET=12
CFLAGS += -DARCH_ARMV7M -Wall -mcpu=cortex-m4 -mthumb -O2
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffunction-sections
CFLAGS += -Wl,--gc-sections -lm
CFLAGS += -T $(UAS_ROOT)/target/cw308_stm32f3/build/linker.ld
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f3/bsp/CMSIS/core
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f3/bsp/CMSIS/device
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f3/bsp
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f3/bsp/stm32f3
CFLAGS += -DSTM32F303xC -DSTM32F3 -DSTM32 -DDEBUG

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

TARGET_SRCS =$(UAS_ROOT)/target/cw308_stm32f3/bsp/cw308_stm32f3_bsp.c \
             $(UAS_ROOT)/target/cw308_stm32f3/bsp/cw308_stm32f3_startup.S \
             $(UAS_ROOT)/target/cw308_stm32f3/bsp/stm32f3_hal_lowlevel.c

