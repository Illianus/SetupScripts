function Run-Script {
    Param([String]$script, $baseUri="https://raw.githubusercontent.com/Microsoft/windows-dev-box-setup-scripts/master/scripts/")
    Write-Host "Installing script from $baseUri$script" -ForegroundColor Yellow -BackgroundColor Blue
    iex ((New-Object net.webclient).DownloadString("$baseUri$script"))
}


function Add-Chocolatey {
    Write-Host "Installing Chocolatey" -ForegroundColor Yellow -BackgroundColor Blue
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function Add-Basics {
    @(
        "Dropbox",
        "googlechrome",
        "atom",
        "openjdk"
    )|%{ 
        Write-Host "Installing $_" -ForegroundColor Yellow -BackgroundColor Blue
        choco install $_ -y 
    }
    RefreshEnv
}

function Add-Scripts {
    @(
        "CommonDevTools.ps1",
        "RemoveDefaultApps.ps1",
        "SystemConfiguration.ps1"
    )|%{Run-Script $_}
    RefreshEnv
}

function Setup-System {
    Add-Chocolatey
    Add-Basics
    Add-Scripts
}

Setup-System
