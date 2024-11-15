#Requires -RunAsAdministrator

if (!Get-Module -ListAvailable -Name 7Zip4PowerShell) 
{
	Install-Module -Name 7Zip4PowerShell
} 



$DEFAULT_InstallPath="C:\MinGW\msys\1.0\home\autobuild\tools"
PSStyle.Progress.View = 'Classic'
$URL_TO_LIBS = "http://builds.kolibrios.org/en_US/data/contrib/sdk/lib/"

$LIST_OF_LIBS = @{
	'libdll.a', 
	'libfreetype.a',
	'libc.dll.a',
	'libSDLn.a',
	'libcurses.a',
	'libz.dll.a',
	'libogg.a',
	'libvorbis.a',
	'libopenjpeg.a'
}

param (
	[string] $InstallPath=$DEFAULT_InstallPath
)


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "toolchain",
	PercentComplete	= 0,
	CurrentOperation = "Create the $InstallPath folder"
}
Write-Progress @OuterLoopProgressParameters

mkdir $InstallPath



$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "toolchain",
	PercentComplete	= 1,
	CurrentOperation = "Download the kos32-gcc toolchain"
}
Write-Progress @OuterLoopProgressParameters

Invoke-WebRequest http://ftp.kolibrios.org/users/Serge/new/Toolchain/msys-kos32-5.4.0.7z -OutFile $InstallPath\kos32-toolchain.7z

$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "toolchain",
	PercentComplete	= 20,
	CurrentOperation = "Unpacking kos32-gcc toolchain"
}
Write-Progress @OuterLoopProgressParameters

Expand-7Zip -ArchiveFileName $InstallPath\kos32-toolchain.7z -TargetPath $InstallPath


$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Installing libraries",
	PercentComplete	= 40,
	CurrentOperation = "Downloading libraries"
}
Write-Progress @OuterLoopProgressParameters

Invoke-WebRequest http://ftp.kolibrios.org/users/Serge/new/Toolchain/sdk-28-10-16.7z -OutFile $InstallPath\win32\mingw32\sdk-28-10-16.7z

# Unpack libs
$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Installing libraries",
	PercentComplete	= 50,
	CurrentOperation = "Downloading libraries"
}
Write-Progress @OuterLoopProgressParameters

Expand-7Zip -ArchiveFileName $InstallPath\win32\mingw32\sdk-28-10-16.7z -TargetPath $InstallPath\win32\mingw32\



for (($i = 0); $i -lt $LIST_OF_LIBS.count; $i++)
{
	$OuterLoopProgressParameters = @{
		Activity    	= "Installing toolchain"
		Status      	= "Updating libraries",
		PercentComplete	= 50+(49 * ($i / $LIST_OF_LIBS.count) ),
		CurrentOperation = "download $($LIST_OF_LIBS[$i])"
	}
	Write-Progress @OuterLoopProgressParameters

	Invoke-WebRequest $URL_TO_LIBS$LIST_OF_LIBS[$i] -OutFile $InstallPath\win32\mingw32\lib\$LIST_OF_LIBS[$i]
}



$OuterLoopProgressParameters = @{
	Activity    	= "Installing toolchain"
	Status      	= "Done!",
	PercentComplete	= 99,
	CurrentOperation = "Adding C:\MinGW\msys\1.0\home\autobuild\tools\win32\bin to PATH"
}
Write-Progress @OuterLoopProgressParameters


Write-Information -MessageData "Installation was successful!"
