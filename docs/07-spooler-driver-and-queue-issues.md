<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# 🧯 07. Spooler, Driver and Queue Issues

**Resolve stuck jobs, spooler crashes, bad drivers and queue corruption safely.**

![Topic](https://img.shields.io/badge/Topic-Spooler_|_Drivers-EF4444?style=flat-square) ![Safety](https://img.shields.io/badge/Safety-Impact_Assessment-F59E0B?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](06-network-printer-troubleshooting.md) • [Next ➡](08-permissions-security-and-point-and-print.md)

</div>

---

## 🔎 Check Queue and Service State

```powershell
Get-Service Spooler
Get-Printer | Select-Object Name, PrinterStatus, DriverName, PortName
Get-PrintJob -PrinterName 'ADL-L2-MFP01'
```

Check whether the queue is paused, offline, retaining failed jobs or using an unexpected driver or port.

## 📄 Remove One Stuck Job First

```powershell
Get-PrintJob -PrinterName 'ADL-L2-MFP01'
Remove-PrintJob -PrinterName 'ADL-L2-MFP01' -ID 42
```

Prefer removing only the failed user's job. Clearing all jobs can destroy valid work submitted by other users.

## 🔄 Restart the Spooler

```powershell
Restart-Service Spooler -Force
```

On a shared production server, first confirm scope, business impact, active jobs and change authority.

## 🧹 Clear Corrupt Spool Files

Use only after normal job removal fails:

```powershell
.\scripts\Reset-PrintSpooler.ps1 -ClearQueuedJobs -WhatIf
```

Manual sequence:

```powershell
Stop-Service Spooler -Force
Remove-Item "$env:WINDIR\System32\spool\PRINTERS\*" -Force
Start-Service Spooler
```

> [!CAUTION]
> This deletes every queued job on the computer or print server. Capture evidence and obtain approval first.

## 🧩 Driver Troubleshooting

Symptoms of a bad driver include:

- Spooler repeatedly stops.
- Jobs remain in **Deleting** or **Printing**.
- Random characters or blank pages.
- Application crashes only when printing.
- Missing trays, duplex, colour or finishing features.
- One queue destabilises other queues using the same driver.

Useful commands:

```powershell
Get-PrinterDriver | Sort-Object Name
Get-Printer | Group-Object DriverName | Sort-Object Count -Descending
```

Recommended replacement process:

1. Create an isolated test queue.
2. Install a signed vendor-supported driver.
3. Test Notepad, PDF, Office and specialist applications.
4. Validate trays, duplex, colour and secure print.
5. Schedule the production driver change.
6. Retain rollback details.

## 🧪 Driver Isolation

Use **Print Management → Drivers → Set Driver Isolation** where supported. Isolation can prevent one faulty driver from crashing the main Spooler process.

## 📋 Event Logs

```powershell
Get-WinEvent -LogName 'Microsoft-Windows-PrintService/Admin' -MaxEvents 100
Get-WinEvent -LogName 'Microsoft-Windows-PrintService/Operational' -MaxEvents 100
Get-WinEvent -LogName System -MaxEvents 200 |
    Where-Object ProviderName -match 'Print|Spooler'
```

Repository collector:

```powershell
.\scripts\Get-PrinterEventLogs.ps1 -Hours 24
```

## ✅ Post-Repair Validation

- Spooler remains running.
- No stuck jobs remain.
- Server test page succeeds.
- Standard user can reconnect and print.
- Multiple applications print correctly.
- Event logs remain clean during the test window.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
