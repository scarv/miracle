
DB      = /tmp/test.db
CLI     = $(UAS_ROOT)/tools/database/cli.py
BACKEND = --backend sqlite
CMD     = $(CLI) $(DB) $(BACKEND)

DEVICE_CFGS = $(shell find $(UAS_ROOT) -maxdepth 3 -path "*.cfg")

init-database:
	$(CMD) -v init --force
	$(CMD) -v insert-targets --from-cfg $(DEVICE_CFGS)
	$(CMD) list cores
	$(CMD) list devices
	$(CMD) list boards
	$(CMD) list targets
