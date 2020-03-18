@echo off
REM This script is inspired by the following GitHub issue:
REM https://github.com/gambit/gambit/issues/480#issuecomment-581215837

setlocal

REM Set environment variables and restore cwd after vcbuildtools.bat changes it
set prevdir=%CD%
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" x64
set PATH=c:\tools\msys64\usr\bin;%PATH%
cd %prevdir%

REM Patch outdated configuration files
wget -O config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
wget -O config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
patch < config.patch

sh -c "./configure --enable-single-host --prefix='%CD:\=/%/dist' CC=cl; make -j4; make install"
REM sh -c "./configure --enable-single-host CC=cl; make -j4;make install"