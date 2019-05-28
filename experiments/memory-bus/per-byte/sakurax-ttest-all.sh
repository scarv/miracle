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
#   $> ./experiments/memory-bus/per-byte/sakurax-ttest-all.sh <serial port>
#

TT_NAME=per-byte-200k

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
        TTEST_CAPTURE=./experiments/memory-bus/per-byte/ttest.py\
        ttest_$1_memory-bus-per-byte
}


# Exit on first failed command
set -e

# Run from the right place
cd $UAS_ROOT

# Make sure
pwd

#
# MB3 Target
#
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/per-byte UAS_TARGET=sakurax_mb3 build all
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/per-byte UAS_TARGET=sakurax_mb3 program
run_ttest sakurax_mb3 0 $1
run_ttest sakurax_mb3 1 $1
run_ttest sakurax_mb3 2 $1
run_ttest sakurax_mb3 3 $1
run_ttest sakurax_mb3 4 $1
run_ttest sakurax_mb3 5 $1
run_ttest sakurax_mb3 6 $1
run_ttest sakurax_mb3 7 $1

${UAS_ROOT}/experiments/memory-bus/per-byte/ttest_graph.sh sakurax_mb3 ${TT_NAME}


#
# MB5 Target
#
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/per-byte UAS_TARGET=sakurax_mb5 build all
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/per-byte UAS_TARGET=sakurax_mb5 program
run_ttest sakurax_mb5 0 $1
run_ttest sakurax_mb5 1 $1
run_ttest sakurax_mb5 2 $1
run_ttest sakurax_mb5 3 $1
run_ttest sakurax_mb5 4 $1
run_ttest sakurax_mb5 5 $1
run_ttest sakurax_mb5 6 $1
run_ttest sakurax_mb5 7 $1

${UAS_ROOT}/experiments/memory-bus/per-byte/ttest_graph.sh sakurax_mb5 ${TT_NAME}

#
# MB8 Target
#
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/per-byte UAS_TARGET=sakurax_mb8 build all
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/per-byte UAS_TARGET=sakurax_mb8 program
run_ttest sakurax_mb8 0 $1
run_ttest sakurax_mb8 1 $1
run_ttest sakurax_mb8 2 $1
run_ttest sakurax_mb8 3 $1
run_ttest sakurax_mb8 4 $1
run_ttest sakurax_mb8 5 $1
run_ttest sakurax_mb8 6 $1
run_ttest sakurax_mb8 7 $1

${UAS_ROOT}/experiments/memory-bus/per-byte/ttest_graph.sh sakurax_mb8 ${TT_NAME}

# Return to previous cwd
cd -

# Finish
echo " --- FINISHED ---"

