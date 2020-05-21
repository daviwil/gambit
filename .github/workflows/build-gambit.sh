#!/bin/sh

mkdir -p dist

if [ -z "$CC" ]; then
  export CC=gcc
fi

# Bootstrap the build with an earlier commit
# TODO: Might be able to use $(git merge-base build-gambit build-gambit-patched)
BOOTSTRAP_COMMIT=3c4d40de908a
git checkout $BOOTSTRAP_COMMIT

echo
echo "### Bootstrapping Gambit compiler from commit $BOOTSTRAP_COMMIT"
echo
./configure --enable-single-host --enable-debug --prefix=$(pwd)/dist CC=$CC
make -j4
make bootstrap

# Put HEAD back to the branch commit
git checkout build-gambit-patched

# Build with the bootstrapped compiler
echo
echo "### Building Gambit with the bootstrapped compiler"
echo
make bootclean
make -j4
make modules
make install
