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
#   $> ./experiments/memory-bus/masked-aes/scale-ttest-all.sh <target> <serial port>
#

TT_NAME=masked-aes-1k

# Exit on first failed command.
set -e

#
# Build
make -B build_$1_memory-bus-masked-aes

#
# Program
make -B program_$1_memory-bus-masked-aes USB_PORT=$2

#
# TTests
# arg 0 - target platform
# arg 1 - number of fixed bytes
# arg 2 - serial port.
function run_ttest {
make -B -f Makefile \
        USB_PORT=$2 \
        TTEST_NAME=${TT_NAME}_$3 \
        TTEST_FLAGS="--keep-data \
                     --fixed-value-len 16 \
                     --fixed-value 0xd1bdf5360d006e7827fb24e1c01b8b7a \
                     --key         0xbd59c0df6103cf9d0d6a2add7f92b478  \
                     --mask-refresh-rate $3" \
        TTEST_NUM_TRACES=1000\
        TTEST_CAPTURE=./experiments/memory-bus/masked-aes/ttest.py \
        ttest_$1_memory-bus-masked-aes
}

pwd

EPATH=$UAS_BUILD/memory-bus/masked-aes/$1

run_ttest $1 $2 1.0
exit
run_ttest $1 $2 0.001
run_ttest $1 $2 0.5
run_ttest $1 $2 0.25
run_ttest $1 $2 0.125
run_ttest $1 $2 0.0

$UAS_ROOT/external/fw-acquisition/ttest_multi_analyse.py \
--graph-ttest $EPATH/ttest-compare.svg \
-t refresh_0.0 \
   $EPATH/masked-aes-20k-25mhz_0.0/ttest-fixed.trs \
   $EPATH/masked-aes-20k-25mhz_0.0/ttest-random.trs \
-t refresh_0.001 \
   $EPATH/masked-aes-20k-25mhz_0.001/ttest-fixed.trs \
   $EPATH/masked-aes-20k-25mhz_0.001/ttest-random.trs \
-t refresh_0.125 \
   $EPATH/masked-aes-20k-25mhz_0.125/ttest-fixed.trs \
   $EPATH/masked-aes-20k-25mhz_0.125/ttest-random.trs \
-t refresh_0.25 \
   $EPATH/masked-aes-20k-25mhz_0.25/ttest-fixed.trs \
   $EPATH/masked-aes-20k-25mhz_0.25/ttest-random.trs \
-t refresh_0.5 \
   $EPATH/masked-aes-20k-25mhz_0.5/ttest-fixed.trs \
   $EPATH/masked-aes-20k-25mhz_0.5/ttest-random.trs \
-t refresh_1.0 \
   $EPATH/masked-aes-20k-25mhz_1.0/ttest-fixed.trs \
   $EPATH/masked-aes-20k-25mhz_1.0/ttest-random.trs
