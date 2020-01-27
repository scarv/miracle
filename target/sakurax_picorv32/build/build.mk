TARGET_ARCH=RV32IMC
CFLAGS += -DTARGET=7
CFLAGS += -DARCH_$(TARGET_ARCH) -Wall -O2
CFLAGS += -march=rv32imc -mabi=ilp32 -nostartfiles -mcmodel=medany
CFLAGS += -Wl,-T -Wl,$(UAS_ROOT)/target/sakurax_picorv32/build/linker.ld

CC      = $(RISCV)/bin/riscv32-unknown-elf-gcc
LD      = $(RISCV)/bin/riscv32-unknown-elf-ld     
AS      = $(RISCV)/bin/riscv32-unknown-elf-as     
OBJDUMP = $(RISCV)/bin/riscv32-unknown-elf-objdump
OBJCOPY = $(RISCV)/bin/riscv32-unknown-elf-objcopy

TARGET_SRCS = $(TARGET_DIR)/srcs/boot.S \
              $(TARGET_DIR)/bsp/sakurax_picorv32_bsp.c

