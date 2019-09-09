<#
 .Synopsis
  Toggles automount settings for newly-connected volumes.

 .Description
  Toggles automount settings for newly-connected volumes. This function
  is intended to be part of a modernized replacement for mountvol, specifically the
  mountvol /e and mountvol /n syntax.

 .Parameter Enable
  Sets automount value to 0, or Enabled

 .Parameter Disable
  Sets automount value to 1, or Disabled

 .Example
   # Enable automount
   Set-Automount -Enable

 .Example
   # Disable automount
   Set-Automount -Disable
#>

function Set-Automount {
    [CmdletBinding()]

    Param(
        [Parameter()]
        [switch]$Enable,

        [Parameter()]
        [switch]$Disable
    )

    begin {
            $KeyName = 'NoAutoMount'
            $RegPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\mountmgr'
            if (!(Get-ItemProperty -Path $RegPath -Name $KeyName -ErrorAction Ignore)) {
                    New-ItemProperty -Path $RegPath -Name $KeyName -PropertyType DWord -Value "0" | Out-Null
            }
    }
    process {
            if ($Enable) {
                Set-ItemProperty -Path $RegPath -Name $KeyName -Value "0"
            }
            elseif ($Disable) {
                Set-ItemProperty -Path $RegPath -Name $KeyName -Value "1"
            }
            else {
                Write-Error "Please select an action using either the -Enable or -Disable flag." -ErrorAction Stop
            }
    }
    end {
        $reg = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\mountmgr
        $CurrentAutoMountStatus = $reg.NoAutoMount
        $Status = switch ($CurrentAutoMountStatus) {
                    0 {"Enabled"}
                    1 {"Disabled"}
                    }
        $OutputObject = [PSCustomObject]@{
            AutomountStatus = $Status
            RegValue = $CurrentAutoMountStatus
            }
        Write-Output $OutputObject
    }

}

