@echo off
title Genisys installer 0.0.1 by Okin_Japan
set TITLE=Genisys installer by Okin_Japan
echo %TITLE%
echo.
echo " *  ____            _        _   __  __ _                  __  __ ____"
echo " * |  _ \ ___   ___| | _____| |_|  \/  (_)_ __   ___      |  \/  |  _ \"
echo " * | |_) / _ \ / __| |/ / _ \ __| |\/| | | '_ \ / _ \_____| |\/| | |_) |"
echo " * |  __/ (_) | (__|   <  __/ |_| |  | | | | | |  __/_____| |  | |  __/"
echo " * |_|   \___/ \___|_|\_\___|\__|_|  |_|_|_| |_|\___|     |_|  |_|_|" 
REM :lang
REM improving
REM echo *********** Select your langage ************
REM echo "*[English] > 1"
REM echo "*[���{��]  > 2"
REM echo "*[(���V�A��̗\��)] �� 3"
REM echo *********************************************
REM echo.
REM set /p NUM0="Select your language in the number.>"
REM if "%NUM0%"=="1" goto checkbit
REM if "%NUM0%"=="2" goto checkbit-jpn
REM if "%NUM0%"=="3" goto checkbit-rus
REM if "%NUM0%"=="" goto confirm

set /p NUM="Do you want to continue?/���s���܂���?(y/N)"
if "%NUM%"=="y" goto checkbit
if "%NUM%"=="n" goto end
if "%NUM%"=="N" goto end
goto end


REM :confirm
REM echo "Not selected. Con."
REM echo.
REM goto 

:checkbit
echo %PROCESSOR_ARCHITECTURE% | find "64" > nul
IF not errorlevel 1 GOTO 64bit
GOTO 32bit

REM :checkbit-jpn
REM echo %PROCESSOR_ARCHITECTURE% | find "64" > nul
REM IF not errorlevel 1 GOTO 64bit-jpn
REM GOTO 32bit-jpn

REM :checkbit-rus
REM echo %PROCESSOR_ARCHITECTURE% | find "64" > nul
REM IF not errorlevel 1 GOTO 64bit-rus
REM GOTO 32bit-rus


REM VER | find "Version 6.2." > nul 
REM IF not errorlevel 1 GOTO Win_8or2012 

:64bit
echo "Find running 64bit Windows." 
echo "Install PHP 64bit version"
echo "***** Select PHP version *****"
REM echo "[5] PHP5 : Older.There is,however compatible"
echo "[7] PHP7 : Newer,faster. There is but any plugins that don't work."
echo "******************************"
set /p NUMe="Select  in the number."
REM if "%NUMe%"=="5" goto inst5-64
if "%NUMe%"=="7" goto inst7-64
REM goto error-64bit
goto inst7-64

:error-64bit
echo "Not selected. Please re-type."
goto 64bit

:32bit
echo "Find running 32bit Windows." 
echo "Install PHP 32bit version" 
echo "***** Select PHP version *****"
REM echo "[5] PHP5 : Older.There is,however compatible (Sorry.Can't use PHP5.) "
echo "[7] PHP7 : Newer,faster. There is but any plugins that don't work."
echo "******************************"
set /p NUMf="Select  in the number."
REM if "%NUMf%"=="5" goto inst5-32
if "%NUMf%"=="7" goto inst7-32
REM goto error-32bit
goto inst7-32
 

:error-32bit
echo "Not selected. Please re-type."
goto 32bit
 

REM install php
:inst5-64
REM echo "Installing Visual C++ Redistributable for Visual Studio 2015.Follow the window."
REM VC2015\vc_redist.x64.exe
REM echo "Downloading PHP5"
echo "Sorry.Can't use PHP5."
goto inst7-64
:inst5-32
REM echo "Installing Visual C++ Redistributable for Visual Studio 2015.Follow the window."
REM VC2015\vc_redist.x86.exe
REM echo "Downloading PHP5"
echo "Sorry.Can't use PHP5."
goto inst7-32

:inst7-64
echo "Installing Visual C++ Redistributable for Visual Studio 2015.Follow the window."
VC2015\vc_redist.x64.exe 
echo "Downloading PHP7"
tools\wget --no-check-certificate https://github.com/iTXTech/PHP-Genisys/blob/master/php_7.0.2_win_x64.tar.xz?raw=true
echo "Installing PHP7"
tools\7z.exe x -obin\ php_7.0.2_win_x64.tar.xz
tools\7z.exe x bin\php_7.0.2_win_x64.tar
echo "Delate tempfile"
del bin\php_7.0.2_win_x64.tar
del php_7.0.2_win_x64.tar.xz
goto src
:inst7-32
echo "Installing Visual C++ Redistributable for Visual Studio 2015.Follow the window."
VC2015\vc_redist.x86.exe
echo "Downloading PHP7"
tools\wget --no-check-certificate https://github.com/iTXTech/PHP-Genisys/blob/master/php_7.0.2_win_x86.tar.xz?raw=true
echo "Installing PHP7"
tools\7z.exe x -obin\ php_7.0.2_win_x86.tar.xz
tools\7z.exe x bin\php_7.0.2_win_x86.tar
echo "Delate tempfile"
del bin\php_7.0.2_win_x86.tar
del php_7.0.2_win_x86.tar.xz
goto src
:src
echo "Donwloading Genisys"
tools\wget --no-check-certificate https://github.com/iTXTech/Genisys/archive/master.zip
echo "Installing Genisys"
tools\7z x master
del master
move Genisys-master\src src
move Genisys-master\start.cmd start.cmd
rd /s /q Genisys-master
echo "All Done! Enjoy your Minecraft PE Server!"

set /p NUM="Do you want to start your server?/�T�[�o�[���N�����܂���?(Y/n)"
if "%NUM%"=="y" goto start
if "%NUM%"=="Y" goto start
if "%NUM%"=="n" goto end
if "%NUM%"=="" goto start
goto start
:start
@echo off
TITLE Genisys server software for Minecraft: Pocket Edition
cd /d %~dp0

if exist bin\php\php.exe (
	set PHPRC=""
	set PHP_BINARY=bin\php\php.exe
) else (
	set PHP_BINARY=php
)

if exist Genisys*.phar (
	set POCKETMINE_FILE=Genisys*.phar
) else (
    if exist PocketMine-MP.phar (
        set POCKETMINE_FILE=PocketMine-MP.phar
	) else (
	    if exist src\pocketmine\PocketMine.php (
	        set POCKETMINE_FILE=src\pocketmine\PocketMine.php
        ) else (
            if exist Genisys.phar (
                set POCKETMINE_FILE=Genisys.phar
            ) else (
		        echo "[ERROR] Couldn't find a valid Genisys installation."
		        pause
		        exit 8
		    )
	    )
	)
)

if exist bin\mintty.exe (
	start "" bin\mintty.exe -o Columns=88 -o Rows=32 -o AllowBlinking=0 -o FontQuality=3 -o Font="DejaVu Sans Mono" -o FontHeight=10 -o CursorType=0 -o CursorBlinks=1 -h error -t "PocketMine-iTX" -i bin/pocketmine.ico -w max %PHP_BINARY% %POCKETMINE_FILE% --enable-ansi %*
) else (
	%PHP_BINARY% -c bin\php %POCKETMINE_FILE% %*
)
exit

:end
echo Have a nice day!
pause
exit