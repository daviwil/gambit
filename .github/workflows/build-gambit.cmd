@echo off
REM This script is inspired by the following GitHub issue:
REM https://github.com/gambit/gambit/issues/480#issuecomment-581215837

setlocal

if "%GITHUB_ACTIONS%" == "true" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.16
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.16
)

set PATH=c:\tools\msys64\usr\bin;%PATH%

REM Update outdated configuration files and patch makefile
wget -O config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
wget -O config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
patch < .github\workflows\makefile.patch

sh -c "./configure --enable-single-host --prefix='%CD:\=/%/dist' CC=cl; make -j4; make install"

REM cat config.log