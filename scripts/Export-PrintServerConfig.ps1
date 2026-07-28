[CmdletBinding()]
param(
    [string]$ComputerName = $env:COMPUTERNAME,
    [string]$OutputPath = ".\$ComputerName-$(Get-Date -Format yyyyMMdd-HHmmss).printerExport"
)

$printBrm = Join-Path $env:WINDIR 'System32\spool\tools\PrintBrm.exe'
if (-not (Test-Path $printBrm)) { throw "PrintBrm.exe not found at $printBrm" }

& $printBrm -B -S "\\$ComputerName" -F $OutputPath
if ($LASTEXITCODE -ne 0) { throw "PrintBRM export failed with exit code $LASTEXITCODE" }
Write-Host "Export completed: $OutputPath"
