@echo off
rem
rem Compile for Win32 using Borland C++ 5.5
rem

setlocal

set BINDIR=C:\BIN
set BC5=C:\APPS\BCC55
PATH=%BC5%\BIN;%PATH%

set SYMBOLS=
set DEBUG=
if "%1"=="-d" set SYMBOLS=-v
if "%1"=="-d" shift

if "%1"=="-D" set SYMBOLS=-v
if "%1"=="-D" set DEBUG=-DDEBUG=1
if "%1"=="-D" shift

if "%1"=="" goto all
if "%1"=="md100" goto md100
if "%SYMBOLS%"=="-v" goto debug

%BC5%\bin\bcc32 -nwin32 -w-obs %1.c wave.c
if errorlevel 1 goto exit
if exist %BINDIR% copy win32\%1.exe %BINDIR%\
goto exit

:debug
%BC5%\bin\bcc32 -Od -nwin32 -edebug\%1_d.exe %SYMBOLS% %DEBUG% %1.c wave.c
if errorlevel 1 goto exit
if exist win32\debug\%1_d.tds touch win32\debug\%1_d.tds
echo win32\debug\%1_d.exe created
goto exit

:all
if exist win32\*.obj del win32\*.obj
if exist win32\*.exe del win32\*.exe

%BC5%\bin\bcc32 %SYMBOLS% -owin32\wave.obj -c wave.c
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 list702.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 list730.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 list850.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 list8000.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 listX07.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 list74.c  win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 wave730.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 wave850.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 waveX07.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 wav2raw.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 wav2wav.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 bas702.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 bas730.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 bas850.c win32\wave.obj
if errorlevel 1 goto exit

%BC5%\bin\bcc32 %SYMBOLS% -nwin32 -w-obs basX07.c win32\wave.obj
if errorlevel 1 goto exit

if exist %BINDIR% copy win32\*.exe %BINDIR%\

:md100

%BC5%\bin\implib win32\lib\libdsk-bc5.lib win32\libdsk.dll
set OPTS=%SYMBOLS% -nwin32 -Iwin32\lib -DLIBDSK -DWIN32
%BC5%\bin\bcc32 %OPTS% md100.c win32\lib\libdsk-bc5.lib win32\lib\wildargs.obj
if errorlevel 2 goto exit

if not exist %BINDIR% goto exit

copy win32\md100.exe %BINDIR%\
copy win32\libdsk.dll %BINDIR%\

:exit
if exist win32\*.obj del win32\*.obj
if exist win32\*.tds del win32\*.tds
