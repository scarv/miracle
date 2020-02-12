
export ISSM_DBG_DIR = $(IAMCU_TOOLCHAIN_DIR)/../../../../debugger/openocd

ISSM_OPENOCD  = $(ISSM_DBG_DIR)/bin/openocd

ISSM_BOOT_ROM = $(TARGET_DIR)/program/quark_d2000_rom.bin

PROGRAM_DEPS  = $(call map_experiment_hex) \
                $(call map_experiment_elf) \
                $(call map_experiment_bin)

program: $(PROGRAM_DEPS)
    ifeq ($(PROGRAM_WITH_OPENOCD),0)
	$(error I dont know how to program this target without openocd)
    else
	$(ISSM_OPENOCD) \
       -f $(ISSM_DBG_DIR)/scripts/interface/ftdi/olimex-arm-usb-ocd-h.cfg  \
       -f $(TARGET_DIR)/program/quark_d2000_ufo.cfg \
       -c "init" \
       -c "reset halt" \
       -c "set QUARK_D2000_OTPC_DATA_WRITE_ENABLED 1" \
       -c "targets" \
       -c "load_image   $(call map_experiment_bin) 0x00180000" \
       -c "verify_image $(call map_experiment_bin) 0x00180000" \
       -c "reset run" \
       -c "targets" \
       -c "reset run" \
       -c "exit" ; echo "Programming done"
    endif

