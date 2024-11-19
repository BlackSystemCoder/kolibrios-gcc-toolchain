#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'kos32-gcc' # arbitrary name for the package, used in messages

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights


$INSTALL_PATH = Read-Host 'Path to install toolchain(Enter - default)'

C:\ProgramData\Chocolatey\lib\kos32-gcc\tools\install.ps1

Out-File -FilePath C:\ProgramData\Chocolatey\lib\kos32-gcc\install-path -InputObject $INSTALL_PATH

