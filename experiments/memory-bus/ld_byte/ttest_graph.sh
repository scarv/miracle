#!/bin/bash

#
# Graph all of the t-statistic traces for the load byte captures
# on a single graph
#

TARGET=$1
TTEST_NAME=$2
GRAPH=$3

$UAS_ROOT/external/fw-acquisition/ttest_multi_analyse.py \
    --graph-ttest ttest-${GRAPH} \
    --graph-avg-random-trace avg-random-${GRAPH} \
    --graph-avg-fixed-trace avg-fixed-${GRAPH} \
    -t lb0 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_0/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_0/ttest-random.trs \
    -t lb1 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_1/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_1/ttest-random.trs \
    -t lb2 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_2/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_2/ttest-random.trs \
    -t lb3 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_3/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_3/ttest-random.trs \
    -t lb4 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_4/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_4/ttest-random.trs \
    -t lb5 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_5/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_5/ttest-random.trs \
    -t lb6 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_6/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_6/ttest-random.trs \
    -t lb7 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_7/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_7/ttest-random.trs \
    -t lb8 $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_8/ttest-fixed.trs $UAS_ROOT/build/memory-bus/ld_byte/$TARGET/${TTEST_NAME}_8/ttest-random.trs

