#
# This makefile contains common code for adding analysis and capture
# targets to the regs-* experiments.
#
# It expects to be *included* by the Makefile.capture and Makefile.analyse
# files for each of the experiments.
#

ANALYSE_TARGETS = 

define add_analysis_targets

$(eval $(call tgt_ttest_analyse,${1}))

ANALYSE_TARGETS += $(call map_ttest_analyse_tgt,${1})

$(eval $(call tgt_cpa_hw_ttest,${1},di1))
$(eval $(call tgt_cpa_hw_ttest,${1},di2))

ANALYSE_TARGETS += $(call map_cpa_hw_analyse_tgt,${1},di1)
ANALYSE_TARGETS += $(call map_cpa_hw_analyse_tgt,${1},di2)

$(eval $(call tgt_cpa_hd_ttest,${1},di1,di2))

ANALYSE_TARGETS += $(call map_cpa_hd_analyse_tgt,${1},di1,di2)

endef

$(eval $(call add_analysis_targets,))

analyse: $(ANALYSE_TARGETS)

