#
# Top level makefile for the project
#

#
# Used by the SCALE and ChipWhisperer targets, enables re-programmng without
# using the physical buttons on the boards,
PROGRAM_WITH_OPENOCD =0

USB_PORT            ?= /dev/ttyUSB0
USB_BAUD            ?= 9600

TTEST_NUM_TRACES    ?= 1000

SCOPE_CONFIG        ?= $(UAS_ROOT)/target/$(UAS_TARGET)/capture/picoscope5000.cfg
SCOPE_POWER_CHANNEL ?=B

CAPTURE_ARGS        =

#
# Whether or not to skip trace capture if there is already a comparable trace
# set in the database.
SKIP_CAPTURE_IF_PRESENT ?=1

ifeq ($(SKIP_CAPTURE_IF_PRESENT),1)
CAPTURE_ARGS += --skip-if-present
endif

# Make all variables available to submake shells.
export

TARGETS     = sakurax_mb3 \
              sakurax_mb5 \
              sakurax_mb8 \
              sakurax_picorv32 \
              scale_lpc1114fn28 \
              scale_lpc1313fbd48 \
              scale_lpc812m101 \
              cw308_stm32f0 \
              cw308_stm32f1 \
              cw308_stm32f2 \
              cw308_stm32f3 \
              cw308_stm32f4 \
              cw308_stm32f4_16mhz \
              intel_d2000 \
              nxp_lpc1115fbd48

EXPERIMENTS = memory-bus/bus-width-st-bytes \
              memory-bus/bus-width-st-halfword \
              memory-bus/bus-width-st-word \
              memory-bus/bus-width-ld-bytes \
              memory-bus/bus-width-ld-halfword \
              memory-bus/bus-width-ld-word \
              memory-bus/registers-implicit-ld-ld \
              memory-bus/registers-implicit-ld-st \
              memory-bus/registers-implicit-st-ld \
              memory-bus/registers-implicit-st-st-1 \
              memory-bus/registers-implicit-st-st-2 \
              pipeline/regs-xor-lhs \
              pipeline/regs-xor-rhs \
              pipeline/regs-xor-nop \
              pipeline/regs-xor-mov-lhs \
              pipeline/regs-xor-mov-rhs \
              pipeline/cmov-operands \
              pipeline/regs-lshf-lhs \
              pipeline/regs-lshf-rhs \
              pipeline/regs-rshf-lhs \
              pipeline/regs-rshf-rhs \
              speculation/jump-shadow-0 \
              speculation/loop-0 \
              speculation/loop-1 \
              speculation/unpredictable-0 \
              countermeasures/rosita-rotate-unprotected \
              countermeasures/rosita-rotate-protected \
              countermeasures/rosita-ld-ld \
              countermeasures/rosita-st-st \


.PHONY: docs
docs:
	mkdir -p $(UAS_BUILD)/docs
	doxygen docs/experiments.doxyfile

DB_CON      = $(UAS_DB) --backend $(UAS_DB_BACKEND)

# CLI tool used to manually interact with the database
DB_CLI      = $(UAS_ROOT)/tools/database/cli.py $(DB_CON)
FLOW_CAPTURE= $(UAS_ROOT)/tools/flow/capture.py

#
# These variables are appended too by the various add_X macros below.
BUILD_TARGETS        = 
FLOW_TARGETS         = 
TGT_ANALYSIS_TARGETS = 
ALL_ANALYSIS_TARGETS = 

#
# Makes experiment names direcotry path friendly by removing "/" and
# replacing with "-" characters.
#
define map_exp
$(subst /,-,${1})
endef

#
# Creates a Makefile target name from three inputs:
#
# 1 - Command: Should be a verb like "build", "program" or "analyse"
# 2 - Target Device Name
# 3 - Experiment Name
#
define map_tgt
${1}_${2}_$(call map_exp,${3})
endef


#
# Add a build target name to the BUILD_TARGETS variable, so we can
# make the build-all phony target work.
#
# 1. Target device.
# 2. Experiment Name.
#
define add_tgt_build

.PHONY: $(call map_tgt,build,${1},${2})
$(call map_tgt,build,${1},${2}) :
	$(MAKE) -f Makefile.build UAS_TARGET=${1} UAS_EXPERIMENT=${2} all

BUILD_TARGETS += $(call map_tgt,build,${1},${2})

endef


#
# Add a top level target to program a given device with a given experiment.
#
# 1. Target device.
# 2. Experiment Name.
#
define add_tgt_program
.PHONY: $(call map_tgt,program,${1},${2})
$(call map_tgt,program,${1},${2}) : $(call map_tgt,build,${1},${2})
	$(MAKE) -f Makefile.program UAS_TARGET=${1} UAS_EXPERIMENT=${2} program
endef


#
# Add a top level target to capture data from an experiment on a given
# target device.
#
# 1. Target device.
# 2. Experiment Name.
#
define add_tgt_capture
.PHONY: $(call map_tgt,capture,${1},${2})
$(call map_tgt,capture,${1},${2}) : $(call map_tgt,program,${1},${2})
	$(FLOW_CAPTURE)         \
        --baud $(USB_BAUD)  \
        --backend $(UAS_DB_BACKEND) \
        --verbose           \
        --ttest-traces $(TTEST_NUM_TRACES) \
        --scope-power-channel $(SCOPE_POWER_CHANNEL) \
        $(CAPTURE_ARGS) \
        $(UAS_ROOT)/experiments/${2}     \
        $(UAS_ROOT)/target/${1}/${1}.cfg \
        $(UAS_DB)           \
        $(SCOPE_CONFIG)     \
        $(USB_PORT)         

endef


#
# Add a top level target to analyse captured data from an experiment on a
# given target device.
#
# 1. Target device.
# 2. Experiment Name.
#
define add_tgt_analyse
$(call map_tgt,analyse,${1},${2}) :
	@echo "Analysis not implemeted for $${@}"
ALL_ANALYSIS_TARGETS += $(call map_tgt,analyse,${1},${2}) 
endef

#
# Utility command which does build, program and capture steps all in one go.
#
define add_tgt_flow
flow-$(call map_exp,${1}) : \
            $(call map_tgt,build,${UAS_TARGET},${1}) \
            $(call map_tgt,program,${UAS_TARGET},${1}) \
            $(call map_tgt,capture,${UAS_TARGET},${1})
FLOW_TARGETS += flow-$(call map_exp,${1})
TGT_ANALYSIS_TARGETS += $(call map_tgt,analyse,${UAS_TARGET},${1}) 
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

#
# Re-run the "analysis" target for every experiment under the specified
# target device.
analyse-all-experiments-for-target: $(TGT_ANALYSIS_TARGETS)

#
# Re-run the "analysis" target for every experiment under every
# target device.
analyse-all-experiments-for-all-targets: $(ALL_ANALYSIS_TARGETS)


$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_build,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_program,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_capture,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call add_tgt_analyse,$(TGT),$(EXP)))))

build-all: $(BUILD_TARGETS)


