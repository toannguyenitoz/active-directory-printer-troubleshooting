[CmdletBinding()]
param(
    [string]$ComputerName = $env:COMPUTERNAME,
    [string]$OutputPath = ".\PrinterInventory-$ComputerName.csv"
)

$printers = Get-Printer -ComputerName $ComputerName -ErrorAction Stop

$result = foreach ($printer in $printers) {
    $port = Get-PrinterPort -ComputerName $ComputerName -Name $printer.PortName -ErrorAction SilentlyContinue
    [pscustomobject]@{
        ServerName         = $ComputerName
        PrinterName        = $printer.Name
        ShareName          = $printer.ShareName
        DriverName         = $printer.DriverName
        PortName           = $printer.PortName
        PrinterHostAddress = $port.PrinterHostAddress
        Shared             = $printer.Shared
        Published          = $printer.Published
        Location           = $printer.Location
        Comment            = $printer.Comment
        PrinterStatus      = $printer.PrinterStatus
    }
}

$result | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
$result
Write-Host "Inventory exported to $OutputPath"
