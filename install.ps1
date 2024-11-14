@echo off

$DEFAULT_TOOLCHAIN_DIR="C:\MinGW\msys\1.0\home\autobuild\tools"
PSStyle.Progress.View = 'Classic'

if ()
{
    $TOOLCHAIN_DIR=$DEFAULT_TOOLCHAIN_DIR
}
else
{
    $TOOLCHAIN_DIR=%1
}



$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "toolchain",
	PercentComplete	= 0,
	CurrentOperation = "Create the $TOOLCHAIN_DIR folder"
}
Write-Progress @OuterLoopProgressParameters

mkdir $TOOLCHAIN_DIR



$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "toolchain",
	PercentComplete	= 1,
	CurrentOperation = "Download the kos32-gcc toolchain"
}
Write-Progress @OuterLoopProgressParameters

wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/msys-kos32-5.4.0.7z -O $TOOLCHAIN_DIR\kos32-toolchain.7z

$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "toolchain",
	PercentComplete	= 20,
	CurrentOperation = "Unpacking kos32-gcc toolchain"
}
Write-Progress @OuterLoopProgressParameters

7z x -y $TOOLCHAIN_DIR\kos32-toolchain.7z -o$TOOLCHAIN_DIR



$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Installing libraries",
	PercentComplete	= 40,
	CurrentOperation = "Downloading libraries"
}
Write-Progress @OuterLoopProgressParameters


wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/sdk-28-10-16.7z -O $TOOLCHAIN_DIR\win32\mingw32\sdk-28-10-16.7z


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Installing libraries",
	PercentComplete	= 50,
	CurrentOperation = "Downloading libraries"
}
Write-Progress @OuterLoopProgressParameters


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Installing libraries",
	PercentComplete	= 60,
	CurrentOperation = "unpacking libraries"
}
Write-Progress @OuterLoopProgressParameters

7z x -y $TOOLCHAIN_DIR\win32\mingw32\sdk-28-10-16.7z




$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 65,
	CurrentOperation = "download libdll.a"
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libdll.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libdll.a

$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 67,
	CurrentOperation = "download libfreetype.a"
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libfreetype.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libfreetype.a

$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 70,
	CurrentOperation = "download libc.dll.a"
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libc.dll.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libc.dll.a


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 75,
	CurrentOperation = "download libSDLn.a"
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libSDLn.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libSDLn.a


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 78,
	CurrentOperation = "download libcurses.a "
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libcurses.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libcurses.a 


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 82,
	CurrentOperation = "download libz.dll.a"
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libz.dll.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libz.dll.a


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 85,
	CurrentOperation = "download libogg.a"
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libogg.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libogg.a


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 88,
	CurrentOperation = "download libvorbis.a"
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libvorbis.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libvorbis.a


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Updating libraries",
	PercentComplete	= 95,
	CurrentOperation = "download libopenjpeg.a"
}
Write-Progress @OuterLoopProgressParameters

wget http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/libopenjpeg.a -O $TOOLCHAIN_DIR\win32\mingw32\lib\libopenjpeg.a



$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Done!",
	PercentComplete	= 99,
	CurrentOperation = "Adding C:\MinGW\msys\1.0\home\autobuild\tools\win32\bin to PATH"
}
Write-Progress @OuterLoopProgressParameters

set PATH=%PATH%;$TOOLCHAIN_DIR%\win32\bin

$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Done!",
	PercentComplete	= 100,
	CurrentOperation = "download libdll.a"
}
Write-Progress @OuterLoopProgressParameters


Write-Information -MessageData "Installation was successful!"
