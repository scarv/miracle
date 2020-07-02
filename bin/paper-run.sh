#!/bin/bash

set -e
set -x

NUM_TRACES=$1
TARGET=$2


function run_experiment {

make -B \
    PROGRAM_WITH_OPENOCD=1          \
    SKIP_CAPTURE_IF_PRESENT=0       \
    TTEST_NUM_TRACES=$NUM_TRACES    \
    UAS_TARGET=$TARGET              \
    flow-$1 analyse_${TARGET}_${1}

}


run_experiment pipeline-branch-flush-regs
run_experiment pipeline-jump-flush-regs-pre
run_experiment pipeline-jump-flush-regs-post
run_experiment regfile-neighbour-hw
run_experiment regfile-shift-imm
run_experiment speculation-jump-shadow-0
run_experiment speculation-loop-0
run_experiment speculation-loop-1
run_experiment speculation-unpredictable-0
run_experiment countermeasures-rosita-rotate-unprotected
run_experiment countermeasures-rosita-rotate-protected
run_experiment countermeasures-rosita-ld-ld-0
run_experiment countermeasures-rosita-ld-ld-1
run_experiment countermeasures-rosita-ld-ld-2
run_experiment countermeasures-rosita-ld-ld-3
run_experiment countermeasures-rosita-st-st

