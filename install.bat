@echo off

for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"


set TOOLCHAIN_DIR=C:\MinGW\msys\1.0\home\autobuild\tools



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

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libdll.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libdll.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libfreetype.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libfreetype.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libc.dll.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libc.dll.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libSDLn.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libSDLn.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libcurses.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libcurses.a 
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libz.dll.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libz.dll.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libogg.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libogg.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libvorbis.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libvorbis.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libopenjpeg.a -O %TOOLCHAIN_DIR%\win32\mingw32\lib\libopenjpeg.a

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
