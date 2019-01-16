function Run-Script {
    Param([String]$script, $baseUri="https://raw.githubusercontent.com/Microsoft/windows-dev-box-setup-scripts/master/scripts/")
    Write-Host "Installing script from $baseUri$script" -ForegroundColor Yellow
    iex ((New-Object net.webclient).DownloadString("$baseUri$script"))
}


function Add-Chocolatey {
    Write-Host "Installing Chocolatey" -ForegroundColor Yellow
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function Add-Basics {
    @(
        "Dropbox",
        "googlechrome",
        "intellijidea-ultimate",
        "gradle",
        "phpstorm",
        "webstorm",
        "pycharm",
        "androidstudio",
        "atom",
        "openjdk"
    )|%{ 
        Write-Host "Installing $_" -ForegroundColor Yellow
        choco install $_ -y 
    }
    RefreshEnv
}

function Add-Python {
    Write-Host "Installing Python" -ForegroundColor Yellow
    choco install python
    RefreshEnv
    Write-Host "Updating pip" -ForegroundColor Yellow
    python -m pip install --upgrade pip
    @("pandas","numpy","scipy","matplotlib","jupyter")|%{
        Write-Host "Installing $_" -ForegroundColor Yellow
        pip install $_
    }
    RefreshEnv
    Write-Host "Installing Visual C++ Redist" -ForegroundColor Yellow
    choco install -y vcredist2015
}

function Add-Scripts {
    @(
        "CommonDevTools.ps1",
        "Docker.ps1",
        "HyperV.ps1",
        "RemoveDefaultApps.ps1",
        "SystemConfiguration.ps1"
    )|%{Run-Script $_}
}

function Setup-System {
    Add-Chocolatey
    Add-Basics
    Add-Python
    Add-Scripts
    Add-Git-Config
}

Setup-System