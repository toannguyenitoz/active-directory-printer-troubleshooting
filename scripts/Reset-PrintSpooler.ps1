[CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
param(
    [switch]$ClearQueuedJobs
)

$spoolPath = Join-Path $env:WINDIR 'System32\spool\PRINTERS'

if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, 'Stop Print Spooler')) {
    Stop-Service Spooler -Force -ErrorAction Stop
}

if ($ClearQueuedJobs) {
    if ($PSCmdlet.ShouldProcess($spoolPath, 'Delete all queued spool files')) {
        Get-ChildItem -Path $spoolPath -Force -ErrorAction SilentlyContinue |
            Remove-Item -Force -ErrorAction Stop
    }
}

if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, 'Start Print Spooler')) {
    Start-Service Spooler -ErrorAction Stop
}

Get-Service Spooler
