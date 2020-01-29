
CC      = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-gcc
LD      = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-ld     
AS      = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-as     
OBJDUMP = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-objdump
OBJCOPY = $(IAMCU_TOOLCHAIN_DIR)/i586-intel-elfiamcu-objcopy

CFLAGS += -Wno-unused-parameter -ffunction-sections -fdata-sections
CFLAGS += -Os -fomit-frame-pointer -Wall -Wextra
CFLAGS += -march=lakemont -mtune=lakemont -miamcu -msoft-float 
CFLAGS += -fmessage-length=0 
CFLAGS += -T$(TARGET_DIR)/build/qmsi/soc/quark_d2000/x86.ld
CFLAGS += -DHAS_RTC_XTAL=1 -DHAS_HYB_XTAL=1 -DQM_VER_API_MAJOR=1
CFLAGS += -DQM_VER_API_MINOR=3 -DQM_VER_API_PATCH=0 -DQM_LAKEMONT
CFLAGS += -DPRINTF_ENABLE -DPUTS_ENABLE
CFLAGS += -I$(TARGET_DIR)/build/qmsi/include -fno-asynchronous-unwind-tables 
CFLAGS += -I$(TARGET_DIR)/build/qmsi/build/release/quark_d2000/x86/libqmsi/include
CFLAGS += -I$(TARGET_DIR)/build/qmsi/soc/quark_d2000/include
CFLAGS += -I$(TARGET_DIR)/build/qmsi/soc/quark_d2000/include
CFLAGS += -I$(TARGET_DIR)/build/qmsi/board/drivers

LIBQMSI = $(TARGET_DIR)/build/qmsi/build/release/quark_d2000/x86/libqmsi/lib/libqmsi.a

$(LIBQMSI) :
	make -C $(TARGET_DIR)/build/qmsi/drivers all \
        APP_NAME=$(UAS_EXPERIMENT) \
        SOC=quark_d2000 \
        TARGET=x86 

TARGET_SRCS = $(TARGET_DIR)/bsp/intel_d2000_bsp.c $(LIBQMSI)
