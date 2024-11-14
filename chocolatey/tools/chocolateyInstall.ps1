#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'kos32-gcc' # arbitrary name for the package, used in messages
$url = 'http://ftp.kolibrios.org/users/Serge/new/Toolchain/msys-kos32-5.4.0.7z' # download url
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes

.\install.ps1