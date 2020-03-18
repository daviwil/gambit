#!/bin/sh

mkdir -p dist
./configure --enable-single-host --prefix=$(pwd)/dist
make -j4
make check
make install