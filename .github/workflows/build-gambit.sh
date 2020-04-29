#!/bin/sh

mkdir -p dist

./configure --enable-single-host --prefix=$(pwd)/dist
make from-scratch -j4
# make bootstrap -j4
# make modules
make install
