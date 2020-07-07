#!/bin/bash

set -e
set -x

NUM_TRACES=10000

./bin/paper-run.sh $NUM_TRACES sakurax_mb3
./bin/paper-run.sh $NUM_TRACES sakurax_mb5
./bin/paper-run.sh $NUM_TRACES sakurax_mb8
./bin/paper-run.sh $NUM_TRACES sakurax_picorv32

