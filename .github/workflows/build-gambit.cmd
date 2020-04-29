@echo off

setlocal

if "%GITHUB_ACTIONS%" == "true" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.16
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.16
)

set PATH=c:\tools\msys64\usr\bin;%PATH%

if not exist "dist" (
  mkdir dist
)

sh -c "./configure --enable-single-host --prefix='%CD:\=/%/dist' CC=cl; make -j4; make modules; make install"
