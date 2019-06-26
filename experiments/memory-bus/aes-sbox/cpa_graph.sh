#!/bin/bash

#
# Run a CPA attack on all sets of traces.
# on a single graph
#

# Exit on first failed command
set -e

# Print commands as we go.
set -x

SCRIPT=$UAS_ROOT/experiments/memory-bus/aes-sbox/aes_cpa.py
WORK=$UAS_BUILD/memory-bus/aes-sbox

ID=distance
VARIANT=$1

function run_cpa {
    TRACE_SET=$1
    GRAPH_DIR=$(dirname "$1")/$VARIANT-$ID
    LOG_PATH=$GRAPH_DIR/cpa.log

    mkdir -p $GRAPH_DIR

    $SCRIPT \
        --key-bytes 16 \
        --message-bytes 16 \
        --save-path $GRAPH_DIR \
        --log $LOG_PATH \
        --var $VARIANT \
        --max-traces 500\
        --threads 4 \
        --graphs \
        --expected-key 0xbd59c0df6103cf9d0d6a2add7f92b478 \
        $TRACE_SET 
}

run_cpa $WORK/scale_lpc812m101/aes-sbox-10k/ttest-random.trs
run_cpa $WORK/scale_lpc1313fbd48/aes-sbox-10k/ttest-random.trs
run_cpa $WORK/scale_lpc1114fn28/aes-sbox-20k/ttest-random.trs
exit


run_cpa $WORK/sakurax_picorv32/aes-sbox-200k/ttest-random.trs
run_cpa $WORK/sakurax_mb3/aes-sbox-200k/ttest-random.trs
run_cpa $WORK/sakurax_mb5/aes-sbox-200k/ttest-random.trs
run_cpa $WORK/sakurax_mb8/aes-sbox-200k/ttest-random.trs

