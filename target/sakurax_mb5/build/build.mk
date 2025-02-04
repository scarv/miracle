TARGET_ARCH=MICROBLAZE
CFLAGS += -DTARGET=5
CFLAGS += -DARCH_$(TARGET_ARCH) -Wall -O2
CFLAGS += -mlittle-endian -mxl-barrel-shift -mno-xl-soft-div
CFLAGS += -mcpu=v10.0 -mno-xl-soft-mul -Wl,--no-relax -Wl,--gc-sections 
CFLAGS += -Wl,-T -Wl,$(UAS_ROOT)/target/sakurax_mb5/build/linker.ld

CC      = $(UAS_MICROBLAZE_TOOLCHAIN_ROOT)/microblaze-xilinx-elf-gcc
LD      = $(UAS_MICROBLAZE_TOOLCHAIN_ROOT)/microblaze-xilinx-elf-ld     
AS      = $(UAS_MICROBLAZE_TOOLCHAIN_ROOT)/microblaze-xilinx-elf-as     
OBJDUMP = $(UAS_MICROBLAZE_TOOLCHAIN_ROOT)/microblaze-xilinx-elf-objdump
OBJCOPY = $(UAS_MICROBLAZE_TOOLCHAIN_ROOT)/microblaze-xilinx-elf-objcopy

TARGET_SRCS = $(TARGET_DIR)/bsp/sakurax_mb5_bsp.c 

