#!/bin/sh

# Copyright (C) 2019 SCARV project <info@scarv.org>
#
# Use of this source code is restricted per the MIT license, a copy of which
# can be found at https://opensource.org/licenses/MIT (or should be included
# as LICENSE.txt within the associated archive or repository).

export REPO_HOME="${PWD}"

export REPO_VERSION_MAJOR="0"
export REPO_VERSION_MINOR="1"
export REPO_VERSION_PATCH="0"

export REPO_VERSION="${REPO_VERSION_MAJOR}.${REPO_VERSION_MINOR}.${REPO_VERSION_PATCH}"

export TEXMFLOCAL="${TEXMFLOCAL}:${REPO_HOME}/external/texmf"

echo "------------------------- Project Setup -------------------------------"

export UAS_ROOT=$PWD
export UAS_BUILD=$UAS_ROOT/work
export UAS_DB=$UAS_BUILD/database.sqlite
export UAS_DB_BACKEND=sqlite
export SCALE_SW=$UAS_ROOT/external/scale-sw
export SCALE_HW=$UAS_ROOT/external/scale-hw
export MIR_DB_REPO_HOME=$UAS_ROOT/external/miracle-db
export MIR_BROWSER_REPO_HOME=$UAS_ROOT/external/miracle-browser

if [ -z $UAS_ARM_TOOLCHAIN_ROOT ] ; then
    export UAS_ARM_TOOLCHAIN_ROOT=/opt/eda/arm/gcc-arm-none-eabi-5_4-2016q3/bin
fi

if [ -z $IAMCU_TOOLCHAIN_DIR ] ; then
    export IAMCU_TOOLCHAIN_DIR=
fi

if [ -z $VIVADO_ROOT ] ; then
    export VIVADO_ROOT=/opt/eda/Xilinx/Vivado/2019.2
fi

if [ -z $UAS_MICROBLAZE_TOOLCHAIN_ROOT ] ; then
    export UAS_MICROBLAZE_TOOLCHAIN_ROOT=/opt/eda/Xilinx/Vitis/2019.2/gnu/microblaze/lin/bin
fi

if [ -z $OPENOCD ] ; then
    export OPENOCD=~/tools/openocd-code/install/bin/openocd
fi

mkdir -p $UAS_BUILD

echo "UAS_ROOT              = $UAS_ROOT"
echo "UAS_BUILD             = $UAS_BUILD"
echo "UAS_DB                = $UAS_DB_BACKEND:///$UAS_DB"
echo "SCALE_SW              = $SCALE_SW"
echo "SCALE_HW              = $SCALE_HW"
echo "OPENOCD               = $OPENOCD"
echo "MIR_DB_REPO_HOME      = $MIR_DB_REPO_HOME"
echo "MIR_BROWSER_REPO_HOME = $MIR_BROWSER_REPO_HOME"
echo "---"
echo "UAS_ARM_TOOLCHAIN_ROOT        = $UAS_ARM_TOOLCHAIN_ROOT"
echo "UAS_MICROBLAZE_TOOLCHAIN_ROOT = $UAS_MICROBLAZE_TOOLCHAIN_ROOT"
echo "IAMCU_TOOLCHAIN_DIR           = $IAMCU_TOOLCHAIN_DIR"
echo "VIVADO_ROOT                   = $VIVADO_ROOT"
echo "-----------------------------------------------------------------------"

if [ ! -f $UAS_DB ]; then

    echo "No pre-existing leakage database found."
    echo "> Initialising UAS Leakage Database..."

    $UAS_ROOT/bin/init-database.sh

else

    echo "Using existing leakage database:"
    echo "> $UAS_DB"

fi


echo "-----------------------------------------------------------------------"

