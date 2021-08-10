function Get-PublicIp {
    [OutputType([ipaddress])]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]

    Param ()

    if (-not $PSBoundParameters.ContainsKey('ErrorAction')) { [System.Management.Automation.ActionPreference] $ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop }
    if (-not $PSBoundParameters.ContainsKey('InformationAction')) { [System.Management.Automation.ActionPreference] $InformationPreference = [System.Management.Automation.ActionPreference]::Continue }
    if (-not $PSBoundParameters.ContainsKey('Verbose')) { [System.Management.Automation.ActionPreference] $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference') }
    if (-not $PSBoundParameters.ContainsKey('Confirm')) { [System.Management.Automation.ActionPreference] $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference') }
    if (-not $PSBoundParameters.ContainsKey('WhatIf')) { [System.Management.Automation.ActionPreference] $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference') }

    if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, 'Get public IP address')) {
        try {
            [ipaddress] $PublicIpAddress = (Invoke-RestMethod -Uri 'https://api.ipify.org?format=json').ip

            return $PublicIpAddress
        } catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
    }
}
