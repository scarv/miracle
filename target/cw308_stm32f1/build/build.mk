TARGET_ARCH=ARMV7M
CFLAGS += -DTARGET=10
CFLAGS += -DARCH_$(TARGET_ARCH) -Wall -march=armv7-m -mcpu=cortex-m3 -mthumb -O2
CFLAGS += -mfloat-abi=soft -ffunction-sections -Wl,--gc-sections -lm
CFLAGS += -T $(UAS_ROOT)/target/cw308_stm32f1/build/linker.ld
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f1/bsp/CMSIS/core
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f1/bsp/CMSIS/device
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f1/bsp
CFLAGS += -I $(UAS_ROOT)/target/cw308_stm32f1/bsp/stm32f1
CFLAGS += -DSTM32F100xB -DSTM32F1 -DSTM32 -DDEBUG

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

TARGET_SRCS =$(UAS_ROOT)/target/cw308_stm32f1/bsp/cw308_stm32f1_bsp.c \
             $(UAS_ROOT)/target/cw308_stm32f1/bsp/cw308_stm32f1_startup.S \
             $(UAS_ROOT)/target/cw308_stm32f1/bsp/stm32f1_hal_lowlevel.c

