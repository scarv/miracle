
UPDATEMEM       = $(VIVADO_ROOT)/bin/updatemem
VIVADO          = $(VIVADO_ROOT)/bin/vivado
VIVADO_LOG      = $(UAS_EXPERIMENT_BUILD)/vivado.log

MEMINFO         = $(TARGET_DIR)/program/sakurax_mb8.mmi
IMPL_BITFILE    = $(TARGET_DIR)/program/bitstream.bit
DOWNLOAD_BITFILE= $(UAS_EXPERIMENT_BUILD)/download.bit

$(DOWNLOAD_BITFILE) : $(IMPL_BITFILE) $(BINOUT)
	$(UPDATEMEM) -force \
	-meminfo $(MEMINFO) \
	-bit     $(IMPL_BITFILE) \
	-data    $(BINOUT) \
	-proc    system_top_i/CPU_MB8 \
	-out     $(DOWNLOAD_BITFILE)
	@rm updatemem.jou updatemem.log

$(VIVADO_LOG) : $(DOWNLOAD_BITFILE)
	$(VIVADO) -mode tcl -log $(VIVADO_LOG) -nojournal \
        -source $(TARGET_DIR)/program/program_bitstream.tcl \
        -tclargs $(DOWNLOAD_BITFILE)
	@rm -f $(dir $(VIVADO_LOG))/vivado*backup.log
	
program: $(VIVADO_LOG)

