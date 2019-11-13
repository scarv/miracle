
program: $(HEX_OUT)
	lpc21isp -wipe -hex $< $(USB_PORT) $(USB_BAUD) 12000

