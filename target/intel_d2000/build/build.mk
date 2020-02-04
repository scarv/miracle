TARGET_ARCH=IA32_X86
CFLAGS += -DTARGET=14
CFLAGS += -DARCH_$(TARGET_ARCH)
CC      = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-gcc
LD      = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-ld     
AS      = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-as     
OBJDUMP = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-objdump
OBJCOPY = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-objcopy

OBJECTS ?= 
BASE_DIR = $(TARGET_DIR)/build/qmsi
APP_DIR  = $(UAS_EXPERIMENT_BUILD)
SOC      = quark_d2000
TARGET   = x86

include $(TARGET_DIR)/build/qmsi/base.mk
include $(TARGET_DIR)/build/qmsi/sys/sys.mk
include $(TARGET_DIR)/build/qmsi/drivers/libqmsi.mk
include $(TARGET_DIR)/build/qmsi/soc/$(SOC)/$(SOC).mk
include $(TARGET_DIR)/build/qmsi/board/drivers.mk

CFLAGS += -Wno-error=unused-parameter
CFLAGS += -Xlinker --gc-sections
CFLAGS += -nostdlib
CFLAGS += -L$(TARGET_DIR)/build/qmsi/build/release/quark_d2000/x86/libqmsi/lib
CFLAGS += -T$(TARGET_DIR)/build/qmsi/soc/quark_d2000/x86.ld

#CFLAGS += -Wno-unused-parameter -ffunction-sections -fdata-sections
#CFLAGS += -Os -fomit-frame-pointer -Wall -Wextra -fmessage-length=0
#CFLAGS += -march=lakemont -mtune=lakemont -miamcu -msoft-float 
#CFLAGS += -DHAS_RTC_XTAL=1 -DHAS_HYB_XTAL=1 -DQM_VER_API_MAJOR=1
#CFLAGS += -DQM_VER_API_MINOR=3 -DQM_VER_API_PATCH=0 -DQM_LAKEMONT
CFLAGS += -DPRINTF_ENABLE -DPUTS_ENABLE
CFLAGS += -lc -lnosys -lsoftfp -lgcc -lqmsi
#CFLAGS += -I$(TARGET_DIR)/build/qmsi/include -fno-asynchronous-unwind-tables 
#CFLAGS += -I$(TARGET_DIR)/build/qmsi/build/release/quark_d2000/x86/libqmsi/include
#CFLAGS += -I$(TARGET_DIR)/build/qmsi/soc/quark_d2000/include
#CFLAGS += -I$(TARGET_DIR)/build/qmsi/soc/quark_d2000/include
#CFLAGS += -I$(TARGET_DIR)/build/qmsi/board/drivers

LIBQMSI = $(TARGET_DIR)/build/qmsi/build/release/quark_d2000/x86/libqmsi/lib/libqmsi.a

#release/quark_d2000/x86/obj/./aes_encrypt.o
#release/quark_d2000/x86/obj/./simpleserial.o
#release/quark_d2000/x86/obj/./main.o
#release/quark_d2000/x86/obj/./utils.o
#release/quark_d2000/x86/obj/app_entry.o
#release/quark_d2000/x86/obj/newlib-syscalls.o
#../qmsi/soc/quark_d2000/release/quark_d2000/x86/obj/clk.o
#../qmsi/soc/quark_d2000/release/quark_d2000/x86/obj/power_states.o
#libqmsi

$(info "OBJECTS: $(OBJECTS)")

TARGET_SRCS = $(TARGET_DIR)/bsp/intel_d2000_bsp.c $(OBJECTS) $(LIBQMSI)
