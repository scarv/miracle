#!/bin/sh

echo "------------------------- Project Setup -------------------------------"

export UAS_ROOT=$PWD
export UAS_BUILD=$UAS_ROOT/build
export SCALE_SW=$UAS_ROOT/external/scale-sw
export SCALE_HW=$UAS_ROOT/external/scale-hw

export UAS_ARM_TOOLCHAIN_ROOT=/usr/bin/
export UAS_MICROBLAZE_TOOLCHAIN_ROOT=/opt/Xilinx/SDK/2018.1/gnu/microblaze/lin/bin

mkdir -p $UAS_BUILD

echo "UAS_ROOT  = $UAS_ROOT"
echo "UAS_BUILD = $UAS_BUILD"
echo "SCALE_SW  = $SCALE_SW"
echo "SCALE_HW  = $SCALE_HW"
echo "---"
echo "UAS_ARM_TOOLCHAIN_ROOT        = $UAS_ARM_TOOLCHAIN_ROOT"
echo "UAS_MICROBLAZE_TOOLCHAIN_ROOT = $UAS_MICROBLAZE_TOOLCHAIN_ROOT"
echo "-----------------------------------------------------------------------"
