#!/bin/bash

#
# Run a CPA attack on all sets of traces.
# on a single graph
#

# Exit on first failed command
set -e

# Print commands as we go.
set -x

SCRIPT=$UAS_ROOT/experiments/memory-bus/masked-aes/aes_cpa.py
WORK=$UAS_BUILD/memory-bus/masked-aes

function run_cpa {
    TRACE_SET=$1
    GRAPH_DIR=$(dirname "$1")
    LOG_PATH=$GRAPH_DIR/cpa.log

    mkdir -p $GRAPH_DIR

    $SCRIPT \
        --key-bytes 16  \
        --message-bytes 16 \
        --save-path $GRAPH_DIR \
        --log $LOG_PATH \
        --max-traces 100000 \
        --max-samples 2000 \
        --threads 1 \
        --graphs \
        --expected-key 0xbd59c0df6103cf9d0d6a2add7f92b478 \
        $TRACE_SET 
}

BASEPATH=$WORK/scale_lpc1114fn28/masked-aes-20k

run_cpa $BASEPATH-25mhz_0.0/ttest-random.trs
run_cpa $BASEPATH-25mhz_0.001/ttest-random.trs
run_cpa $BASEPATH-25mhz_0.125/ttest-random.trs
run_cpa $BASEPATH-25mhz_0.25/ttest-random.trs
run_cpa $BASEPATH-25mhz_0.5/ttest-random.trs
run_cpa $BASEPATH-25mhz_1.0/ttest-random.trs
