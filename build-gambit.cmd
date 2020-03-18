@echo off
REM This script is inspired by the following GitHub issue:
REM https://github.com/gambit/gambit/issues/480#issuecomment-581215837

setlocal

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.16
set PATH=c:\tools\msys64\usr\bin;%PATH%

REM Patch outdated configuration files
wget -O config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
wget -O config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
patch < config.patch

echo "### GIT:"
sh -c "which git"
echo ""

sh -c "./configure --enable-single-host --prefix='%CD:\=/%/dist' CC=cl; make -j4; make install"

cat config.log