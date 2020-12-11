TARGET_ARCH=ARMV7M
CFLAGS += -DTARGET=3
CFLAGS += -DARCH_$(TARGET_ARCH) -Wall -march=armv7-m -mcpu=cortex-m3 -mthumb -nostartfiles -O2
CFLAGS += -T$(UAS_ROOT)/extern/scale-hw/target/lpc1313fbd48/scale.ld
CFLAGS += -L$(UAS_ROOT)/extern/scale-hw/share/lpc13xx
CFLAGS += -I$(UAS_ROOT)/extern/scale-hw/share
CFLAGS += -I$(UAS_ROOT)/extern/scale-hw/share/lpc13xx
CFLAGS += -I$(UAS_ROOT)/extern/scale-hw/target/lpc1313fbd48

CC      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-gcc
LD      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-ld     
AS      = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-as     
OBJDUMP = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objdump
OBJCOPY = $(UAS_ARM_TOOLCHAIN_ROOT)/arm-none-eabi-objcopy

TARGET_SRCS = $(UAS_ROOT)/extern/scale-hw/share/lpc13xx/crt0.S \
              $(UAS_ROOT)/extern/scale-hw/share/lpc13xx/lpc13xx.S \
              $(UAS_ROOT)/target/scale_lpc1313fbd48/bsp/scale_lpc1313fbd48_bsp.c \
              $(UAS_ROOT)/extern/scale-hw/target/lpc1313fbd48/scale.c

