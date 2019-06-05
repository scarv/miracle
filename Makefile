
#
# Top level makefile for the project
#

export USB_PORT ?= /dev/ttyUSB0
export USB_BAUD ?= 9600

export TTEST_NAME       ?= default
export TTEST_NUM_TRACES ?= 10000
export TTEST_FLAGS      ?= 

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
              memory-bus/bus-width \
              memory-bus/per-byte \
              memory-bus/registers \
              memory-bus/aes-sbox

define tgt_build
build_${1}_$(subst /,-,${2}) :
	$(MAKE) -f Makefile.experiment UAS_TARGET=${1} UAS_EXPERIMENT=${2} all
endef

define tgt_program
program_${1}_$(subst /,-,${2}) :
	$(MAKE) -f Makefile.experiment UAS_TARGET=${1} UAS_EXPERIMENT=${2} program
endef

define tgt_ttest
ttest_${1}_$(subst /,-,${2}) :
	$(MAKE) -f Makefile.ttest UAS_TARGET=${1} UAS_EXPERIMENT=${2} ttest
endef

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call tgt_build,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call tgt_program,$(TGT),$(EXP)))))

$(foreach TGT,$(TARGETS), $(foreach EXP,$(EXPERIMENTS), $(eval $(call tgt_ttest,$(TGT),$(EXP)))))

