 #Requires -RunAsAdministrator

param(
	[string]$InstallPath='C:\MinGW\msys\1.0\home\autobuild\tools'
)

if (Get-Module -ListAvailable -Name 7Zip4PowerShell) 
{} 
else
{
	Install-Module -Name 7Zip4PowerShell
}

$URL_TO_LIBS = "http://builds.kolibrios.org/en_US/data/contrib/sdk/lib"

$LIST_OF_LIBS =	'libdll.a',	'libfreetype.a', 'libc.dll.a', 'libSDLn.a', 'libSDL_mixer.a', 'libcurses.a', 'libz.dll.a', 'libogg.a', 'libvorbis.a', 'libopenjpeg.a', 'libopenjpeg.a', 'libsqlite3.dll.a', 'libjbig2dec.a'



Write-Progress -Activity 'Installing toolchain' -Status 'toolchain' -PercentComplete 0 -CurrentOperation 'Create the $InstallPath folder'

mkdir $InstallPath


Write-Progress -Activity 'Installing toolchain' -Status 'toolchain' -PercentComplete 1 -CurrentOperation 'Download the kos32-gcc toolchain'

Invoke-WebRequest http://ftp.kolibrios.org/users/Serge/new/Toolchain/msys-kos32-5.4.0.7z -OutFile $InstallPath\kos32-toolchain.7z


Write-Progress -Activity 'Installing toolchain' -Status 'toolchain' -PercentComplete 20 -CurrentOperation 'Unpacking kos32-gcc toolchain'

Expand-7Zip -ArchiveFileName $InstallPath\kos32-toolchain.7z -TargetPath $InstallPath


Write-Progress -Activity 'Installing toolchain' -Status 'Installing libraries' -PercentComplete 40 -CurrentOperation 'Downloading libraries'

Invoke-WebRequest http://ftp.kolibrios.org/users/Serge/new/Toolchain/sdk-28-10-16.7z -OutFile $InstallPath\win32\mingw32\sdk-28-10-16.7z


Write-Progress -Activity 'Installing toolchain' -Status 'Installing libraries' -PercentComplete 50 -CurrentOperation 'Unpacking libraries'

Expand-7Zip -ArchiveFileName $InstallPath\win32\mingw32\sdk-28-10-16.7z -TargetPath $InstallPath\win32\mingw32\



for (($i = 0); $i -lt $LIST_OF_LIBS.count; $i++)
{
	Write-Progress -Activity 'Installing toolchain' -Status 'Installing libraries' -PercentComplete 50+(50 * ($i / $LIST_OF_LIBS.count) ) -CurrentOperation = 'download $($LIST_OF_LIBS[$i])'

	$LINK = "$URL_TO_LIBS/$LIST_OF_LIBS[$i]"

	Invoke-WebRequest $LINK -OutFile $InstallPath\win32\mingw32\lib\$LIST_OF_LIBS[$i]
}
