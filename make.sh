#!/bin/bash

#source make.sh from shallow_mf directory

export BITREPCPP11=1

INTELONEAPI="intel/oneapi/2023.2"
COMPILER="compiler/2023.2.0"
module load $INTELONEAPI
module load $COMPILER
module load gcc/9.2.0
module load nvhpc/24.5

export PATH="/home/gmap/mrpm/cossevine/fxtran-acdc/bin":$PATH
export PATH="/home/gmap/mrpm/marguina/fxtran/master/bin":$PATH

