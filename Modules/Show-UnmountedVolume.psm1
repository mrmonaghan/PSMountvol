<#
 .Synopsis
  Shows a list of available, unmounted Win32_Volumes.

 .Description
  Shows a list of available, unmounted Win32_Volumes. This function
  is intended to be part of a modernized replacement for mountvol, specifically the
  mountvol /L.

 .Example
   # List available, unmounted Win32_Volumes.
   Show-UnmountedVolumes

   SAMPLE OUTPUT:
   Label DriveLetter DeviceID
    ----- ----------- --------
                  \\?\Volume{1912ef41-6cd3-4f1a-972f-ed29ef771zb7}\
                  \\?\Volume{73faee9a-d315-11e2-959b-185688a4bfc7}\
#>
function Show-UnmountedVolume {
    [CmdletBinding()]
    Param()
    begin {}
    process {
        $Unmounted = Get-WMIObject -Class Win32_Volume | Where-Object {($_.Label -eq $null -and $_.DriveLetter -eq $null)}
    }
    end {
        Write-Output $Unmounted | Select-Object Label,DriveLetter,DeviceID
    }

}


