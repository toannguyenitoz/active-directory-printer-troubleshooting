<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# ⚙️ PowerShell Scripts Catalogue

**Reusable automation for print servers, queues, clients, ports, drivers and incident diagnostics**

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](.)
[![Scripts](https://img.shields.io/badge/Scripts-11-orange?style=for-the-badge)](.)
[![Safety](https://img.shields.io/badge/Safety-WhatIf_Supported-22C55E?style=for-the-badge)](.)

[🏠 Repository Home](../README.md) • [📚 Documentation](../docs/README.md) • [🗂️ Templates](../templates/README.md)

</div>

---

> [!IMPORTANT]
> Open an elevated PowerShell session where required. Read each script's comment-based help and use **`-WhatIf`** before changes that affect queues, ports, configuration or the Print Spooler.

| Script | Category | Description |
|---|---|---|
| [`Add-TcpIpPrinter.ps1`](Add-TcpIpPrinter.ps1) | Provisioning | Adds a Standard TCP/IP port and printer queue |
| [`Remove-PrinterSafely.ps1`](Remove-PrinterSafely.ps1) | Lifecycle | Removes a queue and optionally an unused port |
| [`Repair-ClientPrinter.ps1`](Repair-ClientPrinter.ps1) | Client | Reconnects and repairs shared printer mappings |
| [`Reset-PrintSpooler.ps1`](Reset-PrintSpooler.ps1) | Recovery | Stops spooler, clears jobs when approved and restarts service |
| [`Test-NetworkPrinter.ps1`](Test-NetworkPrinter.ps1) | Diagnostics | Tests ping, TCP 9100 and network reachability |
| [`Get-PrinterInventory.ps1`](Get-PrinterInventory.ps1) | Inventory | Collects queues, drivers and ports |
| [`Find-StalePrinterQueues.ps1`](Find-StalePrinterQueues.ps1) | Audit | Finds unreachable or potentially obsolete queues |
| [`Get-PrinterEventLogs.ps1`](Get-PrinterEventLogs.ps1) | Evidence | Collects PrintService event logs |
| [`Invoke-PrintServerHealthCheck.ps1`](Invoke-PrintServerHealthCheck.ps1) | Health | Runs a consolidated server assessment |
| [`Export-PrintServerConfig.ps1`](Export-PrintServerConfig.ps1) | Backup | Exports configuration for rollback or migration |
| [`Import-PrintServerConfig.ps1`](Import-PrintServerConfig.ps1) | Migration | Imports previously exported configuration |

## 🧪 Example

```powershell
Get-Help .\Add-TcpIpPrinter.ps1 -Full

.\Add-TcpIpPrinter.ps1 `
  -PrinterName "ADL-L2-MFP01" `
  -IPAddress "10.20.30.40" `
  -DriverName "Universal Printing PCL 6" `
  -PublishInAD `
  -WhatIf
```

---

<div align="center">

### 👨‍💻 Author

**Xuan Toan Nguyen**  
*IT Support • Systems Administration • Microsoft 365 • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)

**#ToanNguyenITOz**

</div>
