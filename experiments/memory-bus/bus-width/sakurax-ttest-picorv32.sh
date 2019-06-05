#!/bin/bash

#
# For each FPGA target, run multiple load-byte ttest experiments for
# different numbers of fixed bytes.
#
# Make sure to *source* this script from $UAS_ROOT to make sure it
# will run properly.
#
# Usage:
#
#   $> ./experiments/memory-bus/bus-width/sakurax-ttest-all.sh <serial port>
#

TT_NAME=bus-width-200k

# Print commands as they are executed.
set -x

#
# TTests
# arg 0 - target platform
# arg 1 - number of fixed bytes
# arg 2 - serial port.
function run_ttest {
make -B USB_PORT=$3 \
        USB_BAUD=128000 \
        TTEST_NAME=${TT_NAME}/$2 \
        TTEST_FLAGS="-k --fixed-byte-len $2 --fixed-value 0x73b2ccfd6a39f20f" \
        TTEST_NUM_TRACES=200000 \
        TTEST_CAPTURE=./experiments/memory-bus/bus-width/ttest.py \
        ttest_$1_memory-bus-bus-width
}


# Exit on first failed command
set -e

# Run from the right place
cd $UAS_ROOT

# Make sure
pwd

#
# PicoRV32 Target
#
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/bus-width UAS_TARGET=sakurax_picorv32 build all
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/bus-width UAS_TARGET=sakurax_picorv32 program
run_ttest sakurax_picorv32 0 $1
run_ttest sakurax_picorv32 1 $1
run_ttest sakurax_picorv32 2 $1
run_ttest sakurax_picorv32 3 $1
run_ttest sakurax_picorv32 4 $1
run_ttest sakurax_picorv32 5 $1
run_ttest sakurax_picorv32 6 $1
run_ttest sakurax_picorv32 7 $1

${UAS_ROOT}/experiments/memory-bus/bus-width/ttest_graph.sh sakurax_picorv32 ${TT_NAME}


# Return to previous cwd
cd -

# Finish
echo " --- FINISHED ---"

