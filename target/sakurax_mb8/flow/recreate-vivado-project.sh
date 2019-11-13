#!/bin/bash

set -e
set -x
	
mkdir -p $UAS_BUILD/vivado
cd $UAS_BUILD/vivado/

$VIVADO_ROOT/bin/vivado -source $UAS_ROOT/target/sakurax_mb8/flow/vivado_sakurax_mb8.tcl \
    -mode tcl -nojournal -nolog \
    -tclargs --origin_dir $UAS_ROOT/target/sakurax_mb8

cd -
