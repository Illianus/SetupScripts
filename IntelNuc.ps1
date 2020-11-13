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

function Format-Media {
    Get-Disk | ? PartitionStyle -EQ RAW | Initialize-Disk -PartitionStyle GPT -PassThru | New-Partition -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Media"
}

function Setup-NUC {
    param(
        [Parameter(Mandatory=true)]
        [String]
        $SystemName
    )

    Set-System -SystemName $SystemName
    Format-Media
    Restart-Computer
}

Setup-NUC