@echo off
REM ======================================================
rem Sets path for ADS120, GNU and PERL

set ROOT_DRIVE=c:
set APPS_DIR=
set APPS_PATH=%ROOT_DRIVE%\%APPS_DIR%

set ARMROOT=%APPS_PATH%\ADSv1_2
set UTILROOT=%ROOT_DRIVE%

set GNUPATH=%UTILROOT%\cygwin\bin
set PERLPATH=%UTILROOT%\perl\bin
set ARMPATH=%APPS_PATH%\ADSv1_2\bin

rem
rem ARM Include and Path Variables
rem
set ARMLIB=%ARMROOT%\lib
set ARMINCLUDE=%ARMROOT%\include
set ARMINC=%ARMROOT%\include

set ARMCONF=%ARMROOT%\bin
set ARMDLL=%ARMROOT%\bin
set ARMHOME=%ARMROOT%
set ARM12HOME=%ARMROOT%


rem
rem Path for ADS 1.0.1 GNU, Perl tools
rem
set path=%PERLPATH%;%GNUPATH%;%ARMPATH%;%UTILROOT%;%path%
REM ======================================================

make
