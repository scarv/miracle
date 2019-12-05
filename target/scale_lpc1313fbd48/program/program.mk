
program: $(call map_experiment_hex)
    ifeq ($(PROGRAM_WITH_OPENOCD),0)
	lpc21isp -wipe -hex $< $(USB_PORT) $(USB_BAUD) 12000
    else
	$(OPENOCD) \
	    -f interface/jlink.cfg              \
	    -c "transport select swd"               \
	    -f    target/lpc13xx.cfg                \
	    -c       "init"                         \
	    -c "reset init"                         \
	    -c "flash write_image erase $(call map_experiment_hex)" \
	    -c "reset  run"                         \
	    -c "shutdown"                           \
        -c "exit"
    endif

