
program: $(call map_experiment_hex)
	lpc21isp -wipe -hex $< $(USB_PORT) $(USB_BAUD) 12000

