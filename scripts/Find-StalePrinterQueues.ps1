[CmdletBinding()]
param(
    [string]$ComputerName = $env:COMPUTERNAME
)

$printers = Get-Printer -ComputerName $ComputerName -ErrorAction Stop

foreach ($printer in $printers) {
    $port = Get-PrinterPort -ComputerName $ComputerName -Name $printer.PortName -ErrorAction SilentlyContinue
    $ip = $port.PrinterHostAddress
    $reachable = $null
    $tcp9100 = $null

    if ($ip) {
        $reachable = Test-Connection -ComputerName $ip -Count 1 -Quiet -ErrorAction SilentlyContinue
        $tcp9100 = Test-NetConnection -ComputerName $ip -Port 9100 -InformationLevel Quiet -WarningAction SilentlyContinue
    }

    [pscustomobject]@{
        PrinterName = $printer.Name
        PortName    = $printer.PortName
        IPAddress   = $ip
        Ping        = $reachable
        TCP9100     = $tcp9100
        Status      = $printer.PrinterStatus
        Review      = if ($ip -and -not $reachable -and -not $tcp9100) { 'Potentially stale or offline' } else { 'No immediate issue detected' }
    }
}
