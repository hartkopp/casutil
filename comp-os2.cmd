@echo off
rem
rem Compile for OS/2 using Borland-C++
rem

setlocal

set BINDIR=C:\BIN
set SYMBOLS=

if "%1"=="" goto all
SET SYMBOLS=-v
if "%1"=="md100" goto md100

bcc %SYMBOLS% -nos2 %1.c wave.c
if errorlevel 1 goto exit
if exist %BINDIR% copy os2\%1.exe %BINDIR%\
goto exit

:all

if exist os2\*.exe del os2\*.exe
if exist os2\*.obj del os2\*.obj

bcc %SYMBOLS% -oos2\wave.obj -c wave.c
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 list702.c os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 list730.c os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 list850.c  os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 list8000.c os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 listX07.c  os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 list74.c   os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 wave730.c  os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 wave850.c  os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 waveX07.c  os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 wav2raw.c os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 wav2wav.c os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 bas702.c os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 bas730.c os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 bas850.c os2\wave.obj
if errorlevel 1 goto exit

bcc %SYMBOLS% -nos2 basX07.c os2\wave.obj
if errorlevel 1 goto exit

if exist %BINDIR% copy os2\*.exe %BINDIR%\

:md100
bcc %SYMBOLS% -nos2 md100.c os2\lib\wildargs.obj
if errorlevel 2 goto exit

if exist %BINDIR% copy os2\md100.exe %BINDIR%\

:exit
if exist os2\*.obj del os2\*.obj
