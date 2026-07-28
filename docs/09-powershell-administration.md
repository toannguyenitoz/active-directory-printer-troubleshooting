<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# ⚡ 09. PowerShell Printer Administration

**Inventory, automate, audit and remotely administer enterprise printers.**

![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-5391FE?style=flat-square&logo=powershell&logoColor=white) ![Focus](https://img.shields.io/badge/Focus-Automation-F59E0B?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](08-permissions-security-and-point-and-print.md) • [Next ➡](10-real-world-scenarios.md)

</div>

---

## 📊 Inventory Queues, Ports and Drivers

```powershell
Get-Printer -ComputerName PRINT01 |
    Select-Object Name, ShareName, DriverName, PortName, Shared, Published, PrinterStatus

Get-PrinterPort -ComputerName PRINT01
Get-PrinterDriver -ComputerName PRINT01
```

Export a structured inventory:

```powershell
.\scripts\Get-PrinterInventory.ps1 `
  -ComputerName PRINT01 `
  -OutputPath .\PRINT01-Printers.csv
```

## 🔎 Find Dependencies

```powershell
# Queues using a driver
Get-Printer -ComputerName PRINT01 |
    Where-Object DriverName -eq 'Universal Printing PCL 6'

# Queues using a port
Get-Printer -ComputerName PRINT01 |
    Where-Object PortName -eq 'IP_10.20.30.40'
```

Always check dependencies before removing a port or driver.

## ➕ Add a Client Connection

```powershell
Add-Printer -ConnectionName '\\PRINT01\ADL-L2-MFP01'
```

Set it as default:

```powershell
(New-Object -ComObject WScript.Network).SetDefaultPrinter('\\PRINT01\ADL-L2-MFP01')
```

Repository repair workflow:

```powershell
.\scripts\Repair-ClientPrinter.ps1 `
  -ConnectionName '\\PRINT01\ADL-L2-MFP01' `
  -SetDefault `
  -WhatIf
```

## 🗑️ Remove Old Server Connections

```powershell
Get-Printer |
    Where-Object Name -like '\\OLDPRINT01\*' |
    ForEach-Object {
        Remove-Printer -Name $_.Name -WhatIf
    }
```

Remove `-WhatIf` only after verifying the matching list.

## 🌐 Bulk Connectivity Test

```powershell
Import-Csv .\templates\printer-inventory.csv | ForEach-Object {
    [pscustomobject]@{
        PrinterName = $_.PrinterName
        IPAddress   = $_.IPAddress
        Ping        = Test-Connection $_.IPAddress -Count 1 -Quiet
        TCP9100     = Test-NetConnection $_.IPAddress -Port 9100 -InformationLevel Quiet
    }
}
```

## 🧭 Audit Potentially Stale Queues

```powershell
.\scripts\Find-StalePrinterQueues.ps1 -ComputerName PRINT01 |
    Export-Csv .\StaleQueueReview.csv -NoTypeInformation
```

A failed ping is not sufficient proof that a queue is stale. Confirm device ownership, firewall behaviour and business usage.

## 🖥️ Remote Administration

Some printer cmdlets support `-ComputerName`. For other tasks use PowerShell remoting:

```powershell
Invoke-Command -ComputerName PRINT01 -ScriptBlock {
    Get-Service Spooler
    Get-Printer
}
```

Validate WinRM, firewall, delegation and administrative permissions before relying on remote operations.

## 🧪 Safety Pattern

Scripts that change configuration should use:

```powershell
[CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
```

and wrap the action:

```powershell
if ($PSCmdlet.ShouldProcess($target, $action)) {
    # Change operation
}
```

> [!IMPORTANT]
> Automation should improve consistency, not bypass change control. Log inputs, results, errors and validation for bulk operations.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
