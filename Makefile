
#
# Top level makefile for the project
#

export USB_PORT ?= /dev/ttyUSB0
export USB_BAUD ?= 9600

#
# Used by the SCALE targets, enables re-programmng without using
# the physical buttons on the boards,
export PROGRAM_WITH_OPENOCD=0

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
              example/ld-byte \
              example/ld-half \
              example/ld-word \
              memory-bus/bus-width-bytes
#             memory-bus/per-byte \
#             memory-bus/registers \
#             memory-bus/aes-sbox \
#             memory-bus/masked-aes

docs:
	mkdir -p $(UAS_BUILD)/docs
	doxygen docs/experiments.doxyfile

BUILD_TARGETS = 

FLOW_TARGETS  = 

define map_exp
$(subst /,-,${1})
endef

define map_tgt
${1}_${2}_$(call map_exp,${3})
endef

define tgt_build
$(call map_tgt,build,${1},${2}) :
	$(MAKE) -j 4 -f Makefile.build UAS_TARGET=${1} UAS_EXPERIMENT=${2} all
endef

define add_tgt_build
$(call tgt_build,${1},${2})
BUILD_TARGETS += $(call map_tgt,build,${1},${2})
endef

define add_tgt_program
$(call map_tgt,program,${1},${2}) : $(call map_tgt,build,${1},${2})
	$(MAKE) -f Makefile.program UAS_TARGET=${1} UAS_EXPERIMENT=${2} program
endef

define add_tgt_capture
$(call map_tgt,capture,${1},${2}) :
	$(MAKE) -f experiments/${2}/Makefile.capture UAS_TARGET=${1} UAS_EXPERIMENT=${2} capture
endef

define add_tgt_analyse
$(call map_tgt,analyse,${1},${2}) :
	$(MAKE) -f experiments/${2}/Makefile.analyse UAS_TARGET=${1} UAS_EXPERIMENT=${2} analyse
endef

define add_tgt_flow
flow-$(call map_exp,${1}) : \
            $(call map_tgt,build,${UAS_TARGET},${1}) \
            $(call map_tgt,program,${UAS_TARGET},${1}) \
            $(call map_tgt,capture,${UAS_TARGET},${1}) \
            $(call map_tgt,analyse,${UAS_TARGET},${1}) 
FLOW_TARGETS += flow-$(call map_exp,${1})
endef

define add_tgt_device_test
test_device_${1} :
	./external/fw-acquisition/bin/device-test.py -b $(USB_BAUD) $(USB_PORT)
endef

$(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_flow,$(EXP))))

#
# Run every experiment available for the given target.
# Expects UAS_TARGET to be passed as a command line option.
run-all-experiments-for-target: $(FLOW_TARGETS)

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_build,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_program,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_capture,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_analyse,$(TGT),$(EXP)))))

build-all: $(BUILD_TARGETS)


