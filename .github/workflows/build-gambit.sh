#!/bin/sh

mkdir -p dist

if [ -z "$CC" ]; then
  export CC=gcc
fi

# Default optimization setting of -O1 causes segfaults on MingW64
# so use -O0 to disable it.
case "$(uname)" in
  "MINGW64"*) export CFLAGS="-O0" ;;
esac

# Bootstrap the build against master
git checkout master

echo
echo "### Bootstrapping gsc..."
echo
./configure --enable-single-host --enable-gambitdir=~~execdir/.. --prefix=$(pwd)/dist CC=$CC
make -j4
make bootstrap

# Put HEAD back to the branch commit
git checkout -- include/stamp.h
git checkout build-gambit-patched

# Build with the bootstrapped compiler
echo
echo "### Building Gambit with the bootstrapped gsc"
echo
make -j4
make modules
make install
