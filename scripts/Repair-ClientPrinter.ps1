[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$ConnectionName,
    [switch]$SetDefault
)

if ($ConnectionName -notmatch '^\\\\[^\\]+\\[^\\]+$') {
    throw 'ConnectionName must use the format \\PRINTSERVER\ShareName.'
}

$existing = Get-Printer -Name $ConnectionName -ErrorAction SilentlyContinue
if ($existing -and $PSCmdlet.ShouldProcess($ConnectionName, 'Remove existing printer connection')) {
    Remove-Printer -Name $ConnectionName
}

if ($PSCmdlet.ShouldProcess($ConnectionName, 'Add printer connection')) {
    Add-Printer -ConnectionName $ConnectionName
}

if ($SetDefault -and $PSCmdlet.ShouldProcess($ConnectionName, 'Set as default printer')) {
    (New-Object -ComObject WScript.Network).SetDefaultPrinter($ConnectionName)
}

Get-Printer -Name $ConnectionName | Format-List Name, DriverName, PortName, PrinterStatus
