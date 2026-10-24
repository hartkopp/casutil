@echo off
rem
rem Cross-Compile for DOS using Borland C++ 5.2 under Windows
rem

setlocal

set PATH=C:\APPS\BC5\BIN;%PATH%
set BINDIR=C:\BINDOS

set SYMBOLS=

if "%1"=="" goto all
SET SYMBOLS=-v
if "%1"=="md100" goto md100

bcc %SYMBOLS% -ndos %1.c wave.c
if errorlevel 1 goto exit
if exist %BINDIR%\*.* copy dos\%1.exe %BINDIR%
goto exit

:all

if exist dos\*.exe del dos\*.exe
if exist dos\*.obj del dos\*.obj

bcc %SYMBOLS% -odos\wave.obj -c wave.c
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos list702.c dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos list730.c dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos list850.c  dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos list8000.c  dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos listX07.c  dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos list74.c   dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos wave730.c  dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos wave850.c  dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos waveX07.c  dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos wav2raw.c dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos wav2wav.c dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos bas702.c dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos bas730.c dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos bas850.c dos\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -ndos basX07.c dos\wave.obj
if errorlevel 1 goto exit

if exist %BINDIR%\*.* copy dos\*.exe %BINDIR%

:md100
bcc %SYMBOLS% -ndos md100.c dos\lib\wildargs.obj
if errorlevel 2 goto exit

if exist %BINDIR%\*.* copy dos\md100.exe %BINDIR%

:exit
if exist dos\*.obj del dos\*.obj

