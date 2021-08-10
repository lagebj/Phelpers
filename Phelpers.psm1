foreach ($Folder in @('classes', 'scripts\private', 'scripts\public')) {
    [string] $Root = Join-Path -Path $PSScriptRoot -ChildPath $Folder
    if (Test-Path -Path $Root) {
        # $Files = Get-ChildItem -Path $root -Filter *.ps1 -Recurse
        Get-ChildItem -Path $Root -Filter *.ps1 -Recurse | Where-Object Name -NotLike '*.Tests.ps1' | ForEach-Object {. $_.FullName}
    }
}

Export-ModuleMember -Function (Get-ChildItem -Path "$PSScriptRoot\scripts\public\*.ps1").BaseName