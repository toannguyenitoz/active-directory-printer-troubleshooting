[CmdletBinding()]
param(
    [int]$Hours = 24,
    [string]$OutputPath = ".\PrinterEvents-$(Get-Date -Format yyyyMMdd-HHmmss).csv"
)

$startTime = (Get-Date).AddHours(-$Hours)
$logs = @(
    'Microsoft-Windows-PrintService/Admin',
    'Microsoft-Windows-PrintService/Operational'
)

$events = foreach ($log in $logs) {
    try {
        Get-WinEvent -FilterHashtable @{ LogName = $log; StartTime = $startTime } -ErrorAction Stop |
            Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, LogName, Message
    } catch {
        Write-Warning "Could not read $log. It may be disabled or unavailable."
    }
}

$events | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
$events
Write-Host "Events exported to $OutputPath"
