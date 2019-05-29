#!/bin/bash

#
# Graph all of the t-statistic traces for the load byte captures
# on a single graph
#

TARGET=$1
TTEST_NAME=$2
EXPERIMENT=memory-bus/aes-sbox
GRAPH=$UAS_BUILD/${EXPERIMENT}/${TARGET}/graph-${TTEST_NAME}

$UAS_ROOT/external/fw-acquisition/ttest_multi_analyse.py \
    --graph-ttest ${GRAPH}-ttest.svg \
    --graph-avg-random-trace ${GRAPH}-avg-random.svg \
    --graph-avg-fixed-trace ${GRAPH}-avg-fixed.svg \
    -t lb0 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/0/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/0/ttest-random.trs \
    -t lb1 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/1/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/1/ttest-random.trs \
    -t lb2 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/2/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/2/ttest-random.trs \
    -t lb3 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/3/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/3/ttest-random.trs \
    -t lb4 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/4/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/4/ttest-random.trs \
    -t lb5 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/5/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/5/ttest-random.trs \
    -t lb6 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/6/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/6/ttest-random.trs \
    -t lb7 $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/7/ttest-fixed.trs $UAS_ROOT/build/${EXPERIMENT}/$TARGET/${TTEST_NAME}/7/ttest-random.trs 
