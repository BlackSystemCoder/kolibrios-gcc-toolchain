@echo off

for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"


set DEFAULT_TOOLCHAIN_DIR=C:\MinGW\msys\1.0\home\autobuild\tools

if [%1] == [] (
    set TOOLCHAIN_DIR=%DEFAULT_TOOLCHAIN_DIR%
)
else (
    set TOOLCHAIN_DIR=%1
)


Call :print_msg Create the %TOOLCHAIN_DIR% folder...

mkdir %TOOLCHAIN_DIR%

Call :print_ok Successfully!



call :print_msg Download the kos32-gcc toolchain...

cd %TOOLCHAIN_DIR%

wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/msys-kos32-5.4.0.7z -O %TOOLCHAIN_DIR%\kos32-toolchain.7z

7z x -y %TOOLCHAIN_DIR%\kos32-toolchain.7z -o%TOOLCHAIN_DIR%

Call :print_ok Successfully!



Call :print_msg Downloading libraries...

cd %TOOLCHAIN_DIR%\win32\mingw32

wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/sdk-28-10-16.7z -O %TOOLCHAIN_DIR%\win32\mingw32\sdk-28-10-16.7z

7z x -y %TOOLCHAIN_DIR%\win32\mingw32\sdk-28-10-16.7z

Call :print_ok Successfully!



Call :print_msg Updating libraries

cd %TOOLCHAIN_DIR%\win32\mingw32\lib

wget -r --no-parent http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/
move /-y builds.kolibrios.org\en_US\data\contrib\sdk\lib\* .\
rd /s /q builds.kolibrios.org

Call :print_ok Successfully!



Call :print_msg Adding C:\MinGW\msys\1.0\home\autobuild\tools\win32\bin to PATH

set PATH=%PATH%;%TOOLCHAIN_DIR%%\win32\bin



Call :print_ok Installation was successful!



:print_msg
    echo %ESC%[34m%*%ESC%[%m
exit /b

:print_ok
    echo %ESC%[32m%*%ESC%[%m
exit /b
