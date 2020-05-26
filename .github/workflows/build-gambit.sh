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

# Bootstrap the build with an earlier commit
# TODO: Might be able to use $(git merge-base build-gambit build-gambit-patched)
BOOTSTRAP_COMMIT=c40179c73fc7ae
git checkout $BOOTSTRAP_COMMIT

echo
echo "### Bootstrapping Gambit compiler from commit $BOOTSTRAP_COMMIT"
echo
./configure --enable-single-host --enable-gambitdir=~~execdir/.. --prefix=$(pwd)/dist CC=$CC
make -j4
make bootstrap

# Put HEAD back to the branch commit
git checkout -- include/stamp.h
git checkout build-gambit-patched

# Build with the bootstrapped compiler
echo
echo "### Building Gambit with the bootstrapped compiler"
echo
make -j4
make modules
make install
