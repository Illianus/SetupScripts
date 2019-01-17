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
        "intellijidea-ultimate",
        "gradle",
        "phpstorm",
        "webstorm",
        "pycharm",
        "androidstudio",
        "atom",
        "openjdk",
        "gitkraken",
        "mysql"
    )|%{ 
        Write-Host "Installing $_" -ForegroundColor Yellow -BackgroundColor Blue
        choco install $_ -y 
    }
    RefreshEnv
}

function Add-Python {
    Write-Host "Installing Python" -ForegroundColor Yellow -BackgroundColor Blue
    choco install python -y
    RefreshEnv
    Write-Host "Updating pip" -ForegroundColor Yellow
    python -m pip install --upgrade pip
    @("pandas","numpy","scipy","matplotlib","jupyter")|%{
        Write-Host "Installing $_" -ForegroundColor Yellow
        pip install $_
    }
    RefreshEnv
    Write-Host "Installing Visual C++ Redist" -ForegroundColor Yellow -BackgroundColor Blue
    choco install -y vcredist2015
    RefreshEnv
}

function Add-Scripts {
    @(
        "CommonDevTools.ps1",
        "Docker.ps1",
        "HyperV.ps1",
        "RemoveDefaultApps.ps1",
        "SystemConfiguration.ps1"
    )|%{Run-Script $_}
    RefreshEnv
}

function Setup-System {
    Add-Chocolatey
    Add-Basics
    Add-Python
    Add-Scripts
    Add-Git-Config
}

Setup-System