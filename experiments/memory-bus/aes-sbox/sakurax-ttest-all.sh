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
#   $> ./experiments/memory-bus/aes-sbox/sakurax-ttest-all.sh <serial port>
#

TT_NAME=aes-sbox-100k

#
# TTests
# arg 0 - target platform
# arg 1 - number of fixed bytes
# arg 2 - serial port.
function run_ttest {
make -B USB_PORT=$2 \
        USB_BAUD=128000 \
        TTEST_NAME=${TT_NAME} \
        TTEST_FLAGS="--keep-data \
                     --fixed-value-len 16 \
                     --fixed-value 0xd1bdf5360d006e7827fb24e1c01b8b7a \
                     --key         0xbd59c0df6103cf9d0d6a2add7f92b478" \
        TTEST_NUM_TRACES=100000 \
        TTEST_CAPTURE=./experiments/memory-bus/aes-sbox/ttest.py\
        ttest_$1_memory-bus-aes-sbox
}


# Exit on first failed command
set -e

# Run from the right place
cd $UAS_ROOT

# Make sure
pwd

#
# Picorv32 Target
#
#make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/aes-sbox UAS_TARGET=sakurax_picorv32 build all
#make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/aes-sbox UAS_TARGET=sakurax_picorv32 program
#run_ttest sakurax_picorv32 $1


#
# MB3 Target
#
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/aes-sbox UAS_TARGET=sakurax_mb3 build all
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/aes-sbox UAS_TARGET=sakurax_mb3 program
run_ttest sakurax_mb3 $1

#
# MB5 Target
#
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/aes-sbox UAS_TARGET=sakurax_mb5 build all
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/aes-sbox UAS_TARGET=sakurax_mb5 program
run_ttest sakurax_mb5 $1

#
# MB8 Target
#
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/aes-sbox UAS_TARGET=sakurax_mb8 build all
make -B -f Makefile.experiment USB_PORT=$1 UAS_EXPERIMENT=memory-bus/aes-sbox UAS_TARGET=sakurax_mb8 program
run_ttest sakurax_mb8 $1

# Return to previous cwd
cd -

# Finish
echo " --- FINISHED ---"

