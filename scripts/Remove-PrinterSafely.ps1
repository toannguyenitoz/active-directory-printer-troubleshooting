[CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
param(
    [Parameter(Mandatory)] [string]$PrinterName,
    [switch]$RemoveUnusedPort
)

$printer = Get-Printer -Name $PrinterName -ErrorAction Stop
$portName = $printer.PortName

if ($PSCmdlet.ShouldProcess($PrinterName, 'Remove printer queue')) {
    Remove-Printer -Name $PrinterName
}

if ($RemoveUnusedPort) {
    $remaining = Get-Printer | Where-Object PortName -eq $portName
    if (-not $remaining -and (Get-PrinterPort -Name $portName -ErrorAction SilentlyContinue)) {
        if ($PSCmdlet.ShouldProcess($portName, 'Remove unused printer port')) {
            Remove-PrinterPort -Name $portName
        }
    } else {
        Write-Warning "Port '$portName' is still used by another queue or no longer exists."
    }
}
