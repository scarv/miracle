#!/bin/bash

#
# Run a CPA attack on all sets of traces.
# on a single graph
#

# Exit on first failed command
set -e

# Print commands as we go.
set -x

SCRIPT=$UAS_ROOT/experiments/memory-bus/masked-aes/aes_cpa_worker.py
WORK=$UAS_BUILD/memory-bus/masked-aes

function run_cpa {
    TRACE_SET=$1
    GRAPH_DIR=$(dirname "$1")
    LOG_PATH=$GRAPH_DIR/cpa.log

    mkdir -p $GRAPH_DIR

    $SCRIPT \
        --mask-guess 0 \
        --save-path $GRAPH_DIR \
        --log $LOG_PATH \
        --threads-byte 1 \
        --threads-corrolation 4 \
        --only-guess-first 1 \
        --expected-key 0xbd59c1df6f73cf9d4d6a2add7f92b478 \
        --trace-set $TRACE_SET 
}

BASEPATH=$WORK/scale_lpc1114fn28/masked-aes-20k

run_cpa ${BASEPATH}_1.0/ttest-random.trs
run_cpa ${BASEPATH}_0.0/ttest-random.trs
run_cpa ${BASEPATH}_0.25/ttest-random.trs
run_cpa ${BASEPATH}_0.001/ttest-random.trs
run_cpa ${BASEPATH}_0.125/ttest-random.trs
run_cpa ${BASEPATH}_0.5/ttest-random.trs
