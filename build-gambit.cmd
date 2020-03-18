@echo off
REM This script is inspired by the following GitHub issue:
REM https://github.com/gambit/gambit/issues/480#issuecomment-581215837

setlocal
dir /s /b "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\"

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.0
set PATH=c:\tools\msys64\usr\bin;%PATH%

REM Patch outdated configuration files
wget -O config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
wget -O config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
patch < config.patch

cl

REM MSYS2 should inherit Windows' PATH to find cl.exe
REM set MSYSTEM=MINGW64
REM set MSYS2_PATH_TYPE=inherit

sh -c "./configure --enable-single-host --prefix='%CD:\=/%/dist' CC=cl; make -j4; make install"

cat config.log