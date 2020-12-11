TARGET_ARCH=ARMV6M
CFLAGS += -DTARGET=2
CFLAGS += -DARCH_$(TARGET_ARCH) -Wall -march=armv6-m -mcpu=cortex-m0 -mthumb -nostartfiles -O2
CFLAGS += -T$(UAS_ROOT)/extern/scale-hw/target/lpc1114fn28/scale.ld
CFLAGS += -L$(UAS_ROOT)/extern/scale-hw/share/lpc111x
CFLAGS += -I$(UAS_ROOT)/extern/scale-hw/share
CFLAGS += -I$(UAS_ROOT)/extern/scale-hw/share/lpc111x
CFLAGS += -I$(UAS_ROOT)/extern/scale-hw/target/lpc1114fn28

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

TARGET_SRCS = $(UAS_ROOT)/extern/scale-hw/share/lpc111x/crt0.S \
              $(UAS_ROOT)/extern/scale-hw/share/lpc111x/lpc111x.S \
              $(UAS_ROOT)/target/scale_lpc1114fn28/bsp/scale_lpc1114fn28_bsp.c \
              $(UAS_ROOT)/extern/scale-hw/target/lpc1114fn28/scale.c

