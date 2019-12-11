
#
# This makefile contains common code for adding analysis and capture
# targets to the registers-implicit-* experiments.
#
# It expects to be *included* by the Makefile.capture and Makefile.analyse
# files for each of the experiments.
#


ANALYSE_TARGETS = 

IDX1S = 16
IDX2S = 16 19 20

#
# 1. Index 2
# 2. Index 1
#
define add_analysis_targets

$(eval $(call tgt_ttest_analyse,-${2}-${1}))

ANALYSE_TARGETS += $(call map_ttest_analyse_tgt,-${2}-${1})

$(eval $(call tgt_cpa_hw_ttest,-${2}-${1},di1))
$(eval $(call tgt_cpa_hw_ttest,-${2}-${1},di2))

ANALYSE_TARGETS += $(call map_ttest_cpa_hw_plot,-${2}-${1},di1)
ANALYSE_TARGETS += $(call map_ttest_cpa_hw_plot,-${2}-${1},di2)

$(eval $(call tgt_cpa_hd_ttest,-${2}-${1},di1,di2))

ANALYSE_TARGETS += $(call map_ttest_cpa_hd_plot,-${2}-${1},di1,di2)

endef


$(foreach IDX1,$(IDX1S),\
    $(foreach IDX2,$(IDX2S),\
        $(eval $(call add_analysis_targets,$(IDX2),$(IDX1)))))

analyse: $(ANALYSE_TARGETS)

