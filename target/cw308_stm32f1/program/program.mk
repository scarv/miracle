
program: $(call map_experiment_hex) $(call map_experiment_elf)
    ifeq ($(PROGRAM_WITH_OPENOCD),0)
	$(error "I don't know how to program this target.")
    else
	$(OPENOCD) \
        -f interface/jlink.cfg                  \
        -c "transport select swd"               \
        -f target/stm32f1x.cfg                  \
        -c "init"                               \
        -c "targets"                            \
        -c "halt"                               \
        -c "flash write_image erase $(call map_experiment_hex)" \
        -c "verify_image  $(call map_experiment_hex)" \
        -c "targets"                            \
        -c "reset run"                          \
        -c "targets"                            \
        -c "exit"
    endif


