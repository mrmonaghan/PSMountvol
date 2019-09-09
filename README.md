# PSMountvol
A module designed to modernize/replace the mountvol command line utility. It allows for the manipulation of mounted and unmounted volume in much the same way as mountvol, but utilizes modern assemblies and Powershell syntax.

## Installation
### From PSGallery
Install-Module -Name PSMountvol

### Manual Installation
Download this module from github, and place the PSMountvol module folder to 'C:\Program Files\WindowsPowerShell\Modules'

## Functions

### Mount-Volume
Mounts a volume at the specified drive letter

### Dismount-Volume
Removes the mount point from a drive you specify, then dismounts it.

### Show-UnmountedVolume
Generates a list of unmounted volume DeviceIDs, which can be used in conjunction with Mount-Volume.

### Set-Automount
Allows you to toggle the automatic mounting of new storage devices by using the -Enable and -Disable parameters.

