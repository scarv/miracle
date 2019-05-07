
UAS_EXPERIMENT      ?= translation/nops
UAS_TARGET          ?= scale_lpc1114fn28
UAS_EXPERIMENT_SRC  ?= $(UAS_ROOT)/experiments/$(UAS_EXPERIMENT)

BINOUT     = $(UAS_BUILD)/$(UAS_EXPERIMENT)/$(UAS_TARGET)/program.out
OBJDUMP_OUT= $(UAS_BUILD)/$(UAS_EXPERIMENT)/$(UAS_TARGET)/program.objdump
HEX_OUT    = $(UAS_BUILD)/$(UAS_EXPERIMENT)/$(UAS_TARGET)/program.hex

USB_PORT  ?= /dev/ttyUSB0
USB_BAUD  ?= 9600

CFLAGS    ?= 

include $(UAS_EXPERIMENT_SRC)/Makefile.in
include $(UAS_ROOT)/target/share/Makefile.in
include $(UAS_ROOT)/target/$(UAS_TARGET)/Makefile.in

CFLAGS    += -I$(UAS_ROOT)/experiments/$(UAS_EXPERIMENT)
CFLAGS    += -I$(UAS_ROOT)/target/share
CFLAGS    += -I$(UAS_ROOT)/target/$(UAS_TARGET)

SRCS       = $(UAS_SRCS) $(TARGET_SRCS) $(EXPERIMENT_SRCS)

all: $(BINOUT) $(OBJDUMP_OUT) $(HEX_OUT)

$(BINOUT) : $(SRCS)
	-mkdir -p $(dir $(BINOUT))
	$(CC) $(CFLAGS) $^ -o $@

$(OBJDUMP_OUT) : $(BINOUT)
	$(OBJDUMP) -D $< > $@

$(HEX_OUT) : $(BINOUT)
	$(OBJCOPY) ${OBJCOPY_FLAGS} -O ihex $< $@

clean:
	rm -rf build/*

