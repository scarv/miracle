#!/bin/bash

echo "Programming Intel D2000 target with bootloader..."

ISSM_DBG_DIR=$IAMCU_TOOLCHAIN_DIR/../../../../debugger/openocd
ISSM_OPENOCD=$ISSM_DBG_DIR/bin/openocd
ISSM_BOOT_ROM=$UAS_ROOT/target/intel_d2000/program/quark_d2000_rom.bin

set -e
set -x

$ISSM_OPENOCD \
   -f $ISSM_DBG_DIR/scripts/interface/ftdi/olimex-arm-usb-ocd-h.cfg  \
   -f $UAS_ROOT/target/intel_d2000/program/quark_d2000_ufo.cfg \
   -c "init" \
   -c "reset halt" \
   -c "set QUARK_D2000_OTPC_DATA_WRITE_ENABLED 1" \
   -c "targets" \
   -c "load_image   $ISSM_BOOT_ROM 0x00000000" \
   -c "verify_image $ISSM_BOOT_ROM 0x00000000" \
   -c "reset run" \
   -c "targets" \
   -c "exit" ; echo "Bootloader programmed"
