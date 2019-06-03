#!/bin/bash

#
# Graph all of the t-statistic traces for the load byte captures
# on a single graph
#

TARGET=$1
TTEST_NAME=$2
EXPERIMENT=memory-bus/registers
GRAPH=$UAS_BUILD/${EXPERIMENT}/${TARGET}/graph-${TTEST_NAME}

$UAS_ROOT/external/fw-acquisition/ttest_multi_analyse.py \
    --graph-ttest ${GRAPH}-ttest.svg \
    --graph-avg-random-trace ${GRAPH}-avg-random.svg \
    --graph-avg-fixed-trace ${GRAPH}-avg-fixed.svg \
    -t lb0 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/0/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/0/ttest-random.trs 
