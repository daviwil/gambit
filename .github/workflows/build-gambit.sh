#!/bin/sh

mkdir -p dist

# Bootstrap the build with an earlier commit
git checkout 00acf8685

./configure --enable-single-host --prefix=$(pwd)/dist
make -j4
make install
make bootstrap

# Put HEAD back to the branch commit
git checkout build-gambit-patched

# Build with the bootstrapped compiler
./configure --enable-single-host --prefix=$(pwd)/dist
make -j4
make modules
make install
