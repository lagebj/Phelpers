#Requires -Modules psake

# Builds the module by invoking psake on the build.psake.ps1 script.
Invoke-PSake -buildFile "$PSScriptRoot\Phelpers.Build.ps1" -taskList Build

