TARGET_ARCH=ARMV6M
CFLAGS += -DTARGET=15
CFLAGS += -DARCH_$(TARGET_ARCH) -Wall -march=armv6-m -mcpu=cortex-m0 -mthumb
CFLAGS += -nostartfiles -O2
CFLAGS += -T$(UAS_ROOT)/target/nxp_lpc1115fbd48/build/linker_script.ld
CFLAGS += -I$(UAS_ROOT)/target/nxp_lpc1115fbd48/bsp

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

TARGET_SRCS = $(UAS_ROOT)/target/nxp_lpc1115fbd48/bsp/nxp_lpc1115fbd48_bsp.c \
              $(UAS_ROOT)/target/nxp_lpc1115fbd48/bsp/nxp_lpc1115fbd48_init.c

