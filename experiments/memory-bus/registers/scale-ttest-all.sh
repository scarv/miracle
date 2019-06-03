#!/bin/bash

#
# For a given scale target, run multiple load-byte ttest experiments for
# different numbers of fixed bytes.
#
# Make sure to run this script from $UAS_ROOT to make sure it
# will run properly.
#
# Usage:
#
#   $> ./experiments/memory-bus/registers/scale-ttest-all.sh <target> <serial port>
#

TT_NAME=registers-20k

# Exit on first failed command.
set -e

#
# Build
make -B build_$1_memory-bus-registers

#
# Program
make -B program_$1_memory-bus-registers USB_PORT=$2

#
# TTests
# arg 0 - target platform
# arg 1 - number of fixed bytes
# arg 2 - serial port.
function run_ttest {
make -B -f Makefile \
        USB_PORT=$3 \
        TTEST_NAME=${TT_NAME}/$2 \
        TTEST_FLAGS="-k --fixed-value 0x704ce142aa970aed2d0eb33ef3135247" \
        TTEST_NUM_TRACES=20000 \
        TTEST_CAPTURE=./experiments/memory-bus/registers/ttest.py \
        ttest_$1_memory-bus-registers
}

pwd

run_ttest $1 0 $2

${UAS_ROOT}/experiments/memory-bus/registers/ttest_graph.sh $1 ${TT_NAME}

