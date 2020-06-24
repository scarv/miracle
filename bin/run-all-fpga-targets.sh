#!/bin/bash

set -e
set -x

NUM_TRACES=1000
TARGETS="run-all-experiments-for-target analyse-all-experiments-for-target"
PREFIX="make SKIP_CAPTURE_IF_PRESENT=0 TTEST_NUM_TRACES=$NUM_TRACES $TARGETS"

$PREFIX UAS_TARGET=sakurax_mb3
$PREFIX UAS_TARGET=sakurax_mb5
$PREFIX UAS_TARGET=sakurax_mb8
$PREFIX UAS_TARGET=sakurax_picorv32

