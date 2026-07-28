[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)] [string]$PrinterName,
    [Parameter(Mandatory)] [string]$IPAddress,
    [Parameter(Mandatory)] [string]$DriverName,
    [string]$ShareName = $PrinterName,
    [string]$Location,
    [string]$Comment,
    [switch]$PublishInAD
)

$portName = "IP_$IPAddress"

if (-not (Get-PrinterDriver -Name $DriverName -ErrorAction SilentlyContinue)) {
    throw "Printer driver '$DriverName' is not installed. Install or stage the approved driver first."
}

if (-not (Get-PrinterPort -Name $portName -ErrorAction SilentlyContinue)) {
    if ($PSCmdlet.ShouldProcess($portName, "Create TCP/IP printer port for $IPAddress")) {
        Add-PrinterPort -Name $portName -PrinterHostAddress $IPAddress
    }
}

if (Get-Printer -Name $PrinterName -ErrorAction SilentlyContinue) {
    throw "Printer '$PrinterName' already exists."
}

if ($PSCmdlet.ShouldProcess($PrinterName, 'Create and share printer queue')) {
    $params = @{
        Name       = $PrinterName
        DriverName = $DriverName
        PortName   = $portName
        Shared     = $true
        ShareName  = $ShareName
    }
    if ($PublishInAD) { $params.Published = $true }
    Add-Printer @params

    $setParams = @{ Name = $PrinterName }
    if ($Location) { $setParams.Location = $Location }
    if ($Comment)  { $setParams.Comment = $Comment }
    Set-Printer @setParams
}

Get-Printer -Name $PrinterName | Format-List Name, ShareName, DriverName, PortName, Shared, Published, Location, Comment
