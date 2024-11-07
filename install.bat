
@echo off

7z -v

set TOOLCHAIN_DIR=C:\MinGW\msys\1.0\home\autobuild\tools


cd %TOOLCHAIN_DIR%

wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/msys-kos32-5.4.0.7z -q -O %TOOLCHAIN_DIR%\kos32-toolchain.7z

7z x -y kos32-toolchain.7z


cd %TOOLCHAIN_DIR%\win32\mingw32

wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/sdk-28-10-16.7z -q -O %TOOLCHAIN_DIR%\sdk-28-10-16.7z

7z x -y sdk-28-10-16.7z

cd lib

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libdll.a -q -O libdll.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libfreetype.a -q -O libfreetype.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libc.dll.a -q -O libc.dll.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libSDLn.a -q -O libSDLn.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libcurses.a -q -O libcurses.a 
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libz.dll.a -q -O libz.dll.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libogg.a -q -O libogg.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libvorbis.a -q -O libvorbis.a
wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libopenjpeg.a -q -O libopenjpeg.a

set PATH=%PATH%;%TOOLCHAIN_DIR%%\win32\bin
