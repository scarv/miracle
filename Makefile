
#
# Top level makefile for the project
#

export USB_PORT ?= /dev/ttyUSB0
export USB_BAUD ?= 9600

# Make all variables available to submake shells.
export

TARGETS     = sakurax_mb3 \
              sakurax_mb5 \
              sakurax_mb8 \
              sakurax_picorv32 \
              scale_lpc1114fn28 \
              scale_lpc1313fbd48 \
              scale_lpc812m101 

EXPERIMENTS = example/add \
              example/xor \
              example/addxor \
#             memory-bus/bus-width \
#             memory-bus/per-byte \
#             memory-bus/registers \
#             memory-bus/aes-sbox \
#             memory-bus/masked-aes

BUILD_TARGETS = 

define map_tgt_build
build_${1}_$(subst /,-,${2})
endef

define tgt_build
$(call map_tgt_build,${1},${2}) :
	$(MAKE) -f Makefile.build UAS_TARGET=${1} UAS_EXPERIMENT=${2} all
endef

define add_tgt_build
$(call tgt_build,${1},${2})
BUILD_TARGETS += $(call map_tgt_build,${1},${2})
endef

define add_tgt_program
program_${1}_$(subst /,-,${2}) : $(call map_tgt_build,${1},${2})
	$(MAKE) -f Makefile.program UAS_TARGET=${1} UAS_EXPERIMENT=${2} program
endef

define add_tgt_ttest
ttest_${1}_$(subst /,-,${2}) :
	$(MAKE) -f Makefile.ttest UAS_TARGET=${1} UAS_EXPERIMENT=${2} ttest
endef

define add_tgt_device_test
test_device_${1} :
	./external/fw-acquisition/bin/device-test.py -b $(USB_BAUD) $(USB_PORT)
endef

$(foreach TGT,$(TARGETS), $(eval $(call add_tgt_device_test,$(TGT))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_build,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_program,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_ttest,$(TGT),$(EXP)))))

build-all: $(BUILD_TARGETS)

docs-bsp:
	mkdir -p build/docs
	doxygen docs/bsp.doxyfile
