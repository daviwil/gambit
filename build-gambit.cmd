setlocal

@echo off
REM This script is inspired by the following GitHub issue:
REM https://github.com/gambit/gambit/issues/480#issuecomment-581215837

set PATH=c:\tools\msys64\usr\bin;%PATH%

wget -O config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
wget -O config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'

patch < config.patch

REM sh -c "./configure --enable-single-host --prefix=%CD:\=/% CC=cl; make -j4"
sh -c "./configure --enable-single-host CC=cl; make -j4;make install"