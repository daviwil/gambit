#!/bin/sh

# Batch the makefile to force bootstrapping
patch -N < ./.github/workflows/makefile.patch

mkdir -p dist
./configure --enable-single-host --prefix=$(pwd)/dist
make -j4
make doc
make modules
make install
