#Requires -RunAsAdministrator

function Set-System {
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $SystemName
    )

    Get-Volume -DriveLetter C | Set-Volume -NewFileSystemLabel $SystemName
    Rename-Computer $SystemName
}

Set-System