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
#   $> ./experiments/memory-bus/aes-sbox/scale-ttest-all.sh <target> <serial port>
#

TT_NAME=aes-sbox-20k-25mhz

# Exit on first failed command.
set -e

#
# Build
make -B build_$1_memory-bus-aes-sbox

#
# Program
make -B program_$1_memory-bus-aes-sbox USB_PORT=$2

#
# TTests
# arg 0 - target platform
# arg 1 - number of fixed bytes
# arg 2 - serial port.
function run_ttest {
make -B -f Makefile \
        USB_PORT=$2 \
        TTEST_NAME=${TT_NAME} \
        TTEST_FLAGS="--keep-data \
                     --fixed-value-len 16 \
                     --fixed-value 0xd1bdf5360d006e7827fb24e1c01b8b7a \
                     --key         0xbd59c0df6103cf9d0d6a2add7f92b478" \
        TTEST_NUM_TRACES=20000 \
        TTEST_CAPTURE=./experiments/memory-bus/aes-sbox/ttest.py \
        ttest_$1_memory-bus-aes-sbox
}

pwd

run_ttest $1 $2

