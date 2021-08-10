function Get-AzureIpRange {
    [OutputType([PSCustomObject[]])]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]

    Param ()

    if (-not $PSBoundParameters.ContainsKey('ErrorAction')) { [System.Management.Automation.ActionPreference] $ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop }
    if (-not $PSBoundParameters.ContainsKey('InformationAction')) { [System.Management.Automation.ActionPreference] $InformationPreference = [System.Management.Automation.ActionPreference]::Continue }
    if (-not $PSBoundParameters.ContainsKey('Verbose')) { [System.Management.Automation.ActionPreference] $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference') }
    if (-not $PSBoundParameters.ContainsKey('Confirm')) { [System.Management.Automation.ActionPreference] $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference') }
    if (-not $PSBoundParameters.ContainsKey('WhatIf')) { [System.Management.Automation.ActionPreference] $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference') }

    if ($PSCmdlet.ShouldProcess('Get all Azure public IP ranges')) {
        try {
            [System.Collections.Generic.List[PSCustomObject]] $FormattedList = @()

            (Invoke-RestMethod -Method 'Get' -Uri 'https://download.microsoft.com/download/7/1/D/71D86715-5596-4529-9B13-DA13A5DE5B63/ServiceTags_Public_20210802.json').values |
                ForEach-Object {
                    [PSCustomObject] $IpObject = [PSCustomObject] @{
                        Name = $_.name
                        Region = $_.properties.region
                        Platform = $_.properties.platform
                        Service = $_.properties.systemService
                        AddressPrefixes = $_.properties.addressPrefixes
                        NetworkFeatures = $_.properties.networkFeatures
                    }

                    $FormattedList.Add($IpObject)
                }

            return ($FormattedList -as [PSCustomObject[]])
        } catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
    }
}
