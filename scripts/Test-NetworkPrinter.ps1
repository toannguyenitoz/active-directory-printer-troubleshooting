[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$IPAddress,
    [int[]]$Ports = @(80, 443, 515, 9100)
)

$ping = Test-Connection -ComputerName $IPAddress -Count 2 -Quiet -ErrorAction SilentlyContinue
$results = foreach ($port in $Ports) {
    $open = Test-NetConnection -ComputerName $IPAddress -Port $port -InformationLevel Quiet -WarningAction SilentlyContinue
    [pscustomobject]@{
        IPAddress = $IPAddress
        Ping      = $ping
        Port      = $port
        TcpOpen   = $open
    }
}

$results | Format-Table -AutoSize
