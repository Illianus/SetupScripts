function Start-DiskCheck {
    Start-Process chkdsk -ArgumentList "/scan","/perf" -Verb runas -wait
}

function Start-FileCheck {
    Start-Process sfc -ArgumentList "/scannow" -Verb runas -wait
}

function Start-Dism {
    Start-Process dism -ArgumentList "/online","/cleanup-image","/restorehealth" -Verb runas -wait
    Start-Process dism -ArgumentList "/online","/cleanup-image","/startcomponentcleanup" -verb runas -wait
    Start-Process dism -ArgumentList "/online","/cleanup-image","/startcomponentcleanup","/resetbase" -verb runas -wait
}

function Run-Check-Full {
    Start-DiskCheck
    Start-Dism
    Start-FileCheck
}

Run-Check-Full
