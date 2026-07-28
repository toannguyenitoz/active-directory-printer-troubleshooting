<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# 🎧 11. Helpdesk Printer Incident Runbook

**A repeatable triage, evidence, escalation and closure workflow.**

![Audience](https://img.shields.io/badge/Audience-Service_Desk_|_L2-0078D4?style=flat-square) ![Framework](https://img.shields.io/badge/Framework-ITSM-22C55E?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](10-real-world-scenarios.md)

</div>

---

## 🎫 Minimum Ticket Information

Capture before making changes:

- User name, computer name and contact method.
- Queue name, share path and physical location.
- Exact error message or screenshot.
- Time the issue started.
- One user or multiple users.
- One application or every application.
- Printer panel code and consumable status.
- Recent device, driver, GPO, network or server changes.

## 1️⃣ First-Line Checks

```powershell
hostname
whoami
Get-Printer
Get-Service Spooler
Test-NetConnection PRINT01 -Port 445
```

Then:

1. Confirm the correct printer is selected.
2. Check paper, toner, jams, doors and panel errors.
3. Check whether the queue is paused or offline.
4. Test from Notepad.
5. Review only the user's jobs first.
6. Test the print server and physical printer separately.
7. Reconnect the shared queue where appropriate.
8. Collect evidence before destructive action.

## 2️⃣ Decide the Fault Domain

| Scope | Start Here |
|---|---|
| One application | Application print settings, document and rendering. |
| One user | Mapping, profile, default printer and permissions. |
| One workstation | Local Spooler, driver cache, GPO and connectivity. |
| One queue | Queue state, port, driver and permissions. |
| One physical device | IP, TCP 9100, web interface and hardware panel. |
| Multiple queues on one server | Spooler, resources, drivers, patches and logs. |
| Whole site | Network, VLAN, DNS, firewall or shared infrastructure. |

## 3️⃣ Safe Remediation Order

1. Correct printer selection or application settings.
2. Remove one failed job.
3. Reconnect one user's printer.
4. Correct queue pause/offline state.
5. Correct port or IP configuration.
6. Restart the physical device if approved.
7. Restart the local client Spooler.
8. Restart the shared server Spooler only after impact assessment.
9. Replace a driver or recreate a queue through change control.

## 4️⃣ Evidence Collection

```powershell
Get-Printer | Format-List *
Get-PrinterPort | Format-List *
Get-PrinterDriver | Format-List *
Get-WinEvent -LogName 'Microsoft-Windows-PrintService/Admin' -MaxEvents 100
Get-WinEvent -LogName 'Microsoft-Windows-PrintService/Operational' -MaxEvents 100
```

Repository tools:

```powershell
.\scripts\Get-PrinterEventLogs.ps1 -Hours 24
.\scripts\Invoke-PrintServerHealthCheck.ps1 -ComputerName PRINT01
```

## 5️⃣ Escalate to L2 or Systems Administration When

- The Spooler repeatedly crashes.
- Multiple users or printers are affected.
- A driver, print processor or vendor monitor is suspected.
- GPO or Point and Print policy requires modification.
- Queue recreation or print server migration is required.
- Permissions design or AD group ownership is unclear.
- DNS, VLAN, routing, firewall or switch changes are required.
- The issue involves a business-critical label, cheque or specialist printer.

## 6️⃣ Closure Notes Example

```text
Root cause: The shared queue referenced an obsolete TCP/IP port after the printer IP changed.
Resolution: Created a new Standard TCP/IP Port, updated the queue, and printed test pages from the server and client.
Validation: The user confirmed successful printing from Outlook and Excel.
Prevention: Converted the address to a DHCP reservation and updated the printer inventory.
```

## ✅ Closure Checklist

- User confirms successful printing.
- Representative applications are tested.
- Queue and device show normal state.
- No unrelated jobs were lost.
- Inventory, knowledge article and change record are updated.
- Temporary workarounds are removed.
- Monitoring or follow-up actions have an owner.

> [!IMPORTANT]
> Avoid closing a printer ticket with only “Spooler restarted”. Record the actual fault domain, evidence, resolution, validation and preventive action.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
