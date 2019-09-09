<#
 .Synopsis
  Mounts an unmounted volume using the distinct GUID of the volume.

 .Description
  Mounts an unmounted volume using the distinct GUID of the volume. This function
  is intended to be part of a modernized replacement for mountvol, specifically the
  mountvol [<Drive>:]<Path VolumeName> syntax.

 .Parameter DeviceID
  The unique volume name that is the target of the mount point. The volume name uses
  the following syntax, where GUID is a globally unique identifier: \\\\?\Volume\{GUID}\
  The {} brackets are required.

 .Parameter DriveLetter
  The drive letter at which the volume will be mounted.

 .Example
   # Mount an unmounted volume at E:.
   Mount-Volume -DeviceID '\\\\?\Volume\{GUID}\' -DriveLetter E:

 .Example
   # Mount an unmounted volume at E: using a varible that contains the unique GUID.
   $VolumeID = Get-WMIObject -Class Win32_Volume | Where-Object {$_.Label -eq "DriveLabel"} | Select-Object -ExpandProperty DeviceID
   Mount-Volume -DeviceID $VolumeID -DriveLetter E:
#>

Function Mount-Volume {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory,
        ValueFromPipeline = $true,
        ValueFromPipelineByPropertyName = $True)]
        [object]$DeviceID,

        [Parameter(Mandatory)]
        [string]$DriveLetter

    )

    begin {
        $Drive = Get-WMIObject -Class Win32_Volume | Where-Object {$_.DeviceID -eq $DeviceID}
    }
    process {
        $ProcessOutput = $Drive.AddMountPoint($DriveLetter)
        $ReturnValue = $ProcessOutput.ReturnValue
    }
    end {
        $Drive = Get-WMIObject -Class Win32_Volume | Where-Object {$_.DriveLetter -like $DriveLetter}
        $DriveOutput = [PSCustomObject]@{
            Label = $Drive.Label
            DriveLetter = $Drive.DriveLetter
            DeviceID = $Drive.DeviceID
            Status = $null
            }
        if ($ReturnValue -eq 0) {
                $DriveOutput.status = "Mounted"
        }
        else {$DriveOutput.status = "Failed"}
        Write-Output $DriveOutPut
    }

}


