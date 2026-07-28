[CmdletBinding()]
param(
    [string]$ComputerName = $env:COMPUTERNAME,
    [string]$OutputFolder = '.\PrintServerHealth'
)

New-Item -Path $OutputFolder -ItemType Directory -Force | Out-Null
$timestamp = Get-Date -Format yyyyMMdd-HHmmss

$service = Get-Service -ComputerName $ComputerName -Name Spooler
$printers = Get-Printer -ComputerName $ComputerName
$ports = Get-PrinterPort -ComputerName $ComputerName
$drivers = Get-PrinterDriver -ComputerName $ComputerName

$summary = [pscustomobject]@{
    ComputerName = $ComputerName
    Timestamp    = Get-Date
    SpoolerState = $service.Status
    PrinterCount = $printers.Count
    PortCount    = $ports.Count
    DriverCount  = $drivers.Count
}

$summary | Export-Csv "$OutputFolder\Summary-$timestamp.csv" -NoTypeInformation
$printers | Export-Csv "$OutputFolder\Printers-$timestamp.csv" -NoTypeInformation
$ports | Export-Csv "$OutputFolder\Ports-$timestamp.csv" -NoTypeInformation
$drivers | Export-Csv "$OutputFolder\Drivers-$timestamp.csv" -NoTypeInformation

$summary
Write-Host "Health-check files saved to $OutputFolder"
