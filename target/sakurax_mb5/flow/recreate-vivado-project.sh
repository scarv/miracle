#!/bin/bash

set -e
set -x
	
mkdir -p $UAS_BUILD/vivado
cd $UAS_BUILD/vivado/

$VIVADO_ROOT/bin/vivado -source $UAS_ROOT/target/sakurax_mb5/flow/vivado_sakurax_mb5.tcl \
    -mode tcl -nojournal -nolog \
    -tclargs --origin_dir $UAS_ROOT/target/sakurax_mb5

cd -
