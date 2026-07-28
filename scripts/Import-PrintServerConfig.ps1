[CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
param(
    [Parameter(Mandatory)] [string]$BackupFile,
    [string]$ComputerName = $env:COMPUTERNAME
)

if (-not (Test-Path $BackupFile)) { throw "Backup file not found: $BackupFile" }
$printBrm = Join-Path $env:WINDIR 'System32\spool\tools\PrintBrm.exe'
if (-not (Test-Path $printBrm)) { throw "PrintBrm.exe not found at $printBrm" }

if ($PSCmdlet.ShouldProcess($ComputerName, "Import printer configuration from $BackupFile")) {
    & $printBrm -R -S "\\$ComputerName" -F $BackupFile
    if ($LASTEXITCODE -ne 0) { throw "PrintBRM import failed with exit code $LASTEXITCODE" }
}
