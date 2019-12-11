
#
# NOTE: This file expects to be "included" into $UAS_ROOT/Makefile.program
#

UPDATEMEM       = $(VIVADO_ROOT)/bin/updatemem
VIVADO          = $(VIVADO_ROOT)/bin/vivado
VIVADO_LOG      = $(UAS_EXPERIMENT_BUILD)/vivado.log

IMPL_BITFILE    = $(TARGET_DIR)/program/bitstream.bit
DOWNLOAD_BITFILE= $(UAS_EXPERIMENT_BUILD)/download.bit

SEARCH_RAMB     = $(TARGET_DIR)/program/bitstream_search_ramb.tcl
MMI_FILE        = $(TARGET_DIR)/program/sakurax_picorv32.mmi

$(MMI_FILE) : $(IMPL_BITFILE)
	$(VIVADO) -mode tcl -log $(VIVADO_LOG) -nojournal \
        -source $(SEARCH_RAMB) \
        -tclargs sakurax-picorv32 $(UAS_BUILD)/vivado
	mv $(UAS_ROOT)/BRAM_0.mmi $(MMI_FILE)

regnerate_mmi_file: $(MMI_FILE)

$(DOWNLOAD_BITFILE) : $(IMPL_BITFILE) $(call map_experiment_elf)
	$(UPDATEMEM) -force \
	-meminfo $(MMI_FILE) \
	-bit     $(IMPL_BITFILE) \
	-data    $(call map_experiment_elf) \
	-proc    dummy \
	-out     $(DOWNLOAD_BITFILE)
	@rm updatemem.jou updatemem.log

bitfile : $(DOWNLOAD_BITFILE)
	
.PHONY: program
program: $(DOWNLOAD_BITFILE) $(BINOUT)
	$(VIVADO) -mode tcl -log $(VIVADO_LOG) -nojournal \
        -source $(TARGET_DIR)/program/program_bitstream.tcl \
        -tclargs $(DOWNLOAD_BITFILE)
	@rm -f $(dir $(VIVADO_LOG))/vivado*backup.log
