
#
# This makefile contains common code for adding analysis and capture
# targets to the registers-implicit-* experiments.
#
# It expects to be *included* by the Makefile.capture and Makefile.analyse
# files for each of the experiments.
#

CAPTURE_TARGETS = 

IDX1S = 16
IDX2S = 16 19 20

#
# 1. Index 2
# 2. Index 1
#
define add_capture_target

$(eval $(call tgt_ttest_capture,-${2}-${1},--set idx1=${2} idx2=${1} --zero-fixed))

CAPTURE_TARGETS += $(call map_ttest_capture_tgt,-${2}-${1})

endef

$(foreach IDX1,$(IDX1S),\
    $(foreach IDX2,$(IDX2S),\
        $(eval $(call add_capture_target,$(IDX2),$(IDX1)))))

capture: $(CAPTURE_TARGETS)

