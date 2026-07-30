<a id="top"></a>

<div align="center">

![Repository Header](images/repository-header.svg)

# 🖨️ Active Directory Printer Administration & Troubleshooting

### *Enterprise printer deployment, administration, automation and incident resolution*

[![Windows Server](https://img.shields.io/badge/Windows_Server-2019_|_2022_|_2025-0078D4?style=for-the-badge&logo=windows&logoColor=white)](docs/02-build-a-print-server.md)
[![Active Directory](https://img.shields.io/badge/Active_Directory-Printer_Management-2F5BB7?style=for-the-badge&logo=microsoft&logoColor=white)](docs/01-printing-architecture.md)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](docs/09-powershell-administration.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-22C55E?style=flat-square)](LICENSE)
![Status](https://img.shields.io/badge/Status-Production_Ready-brightgreen?style=flat-square)
![Documentation](https://img.shields.io/badge/Documentation-11_Guides-blueviolet?style=flat-square)
![Case Studies](https://img.shields.io/badge/Real--World_Cases-1_Complete-0EA5E9?style=flat-square)
![Scripts](https://img.shields.io/badge/PowerShell_Scripts-11-orange?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-Windows_10_|_11_|_Server-informational?style=flat-square)

[🚀 Quick Start](#-quick-start) • [📚 Documentation](#-documentation-library) • [🧪 Case Studies](#-real-world-case-studies) • [⚙️ Scripts](#️-powershell-toolkit) • [🧰 Runbook](docs/11-helpdesk-runbook.md) • [🤝 Contributing](CONTRIBUTING.md)

</div>

---

> [!IMPORTANT]
> This repository is designed for **IT Support**, **Service Desk**, **Desktop Support**, **System Administrators**, and Windows Server lab environments managing network printers through **Active Directory, Group Policy, Print Management and PowerShell**.

A practical field guide, troubleshooting knowledge base and PowerShell toolkit for managing printers in an Active Directory environment.

This repository covers the complete printer lifecycle:

- Install and configure Windows print servers.
- Add TCP/IP ports, drivers, print queues and shared printers.
- Publish printers in Active Directory.
- Deploy printers with Group Policy.
- Add or remove printers from user computers.
- Migrate queues between print servers.
- Troubleshoot network printing, spooler, driver, GPO, permissions and Point and Print issues.
- Diagnose direct-IP, WSD and vendor-driver behaviour.
- Collect evidence for escalation and root-cause analysis.
- Audit printer inventory and stale queues with PowerShell.
- Document real-world incidents with symptoms, investigation, resolution and lessons learned.

## 🗂️ Repository Structure

```text
active-directory-printer-troubleshooting/
├── README.md
├── CONTRIBUTING.md
├── Case Studies/           # Detailed incidents based on real troubleshooting
│   └── Case-01-Ghost-Kyocera-Printer.md
├── docs/                   # 11 detailed administration guides
├── scripts/                # 11 PowerShell utilities
├── templates/              # Change, incident and inventory templates
└── images/                 # Repository branding
```

## 🧭 Fast Troubleshooting Flow

```mermaid
flowchart TD
    A[User cannot print] --> B{Only one user?}
    B -->|Yes| C[Check mapping, default printer, driver and profile]
    B -->|No| D{Only one printer?}
    D -->|Yes| E[Test IP, web page, queue, port and hardware]
    D -->|No| F{Multiple printers on same server?}
    F -->|Yes| G[Check Spooler, resources, logs and recent changes]
    F -->|No| H[Check network, DNS, firewall, GPO and authentication]
    C --> I[Clear user jobs and reconnect printer]
    E --> J[Validate TCP 9100 or vendor protocol]
    G --> K[Restart Spooler only after impact assessment]
    H --> L[Run gpresult and Test-NetConnection]
```

## 🚀 Quick Start

```powershell
# Clone the repository
git clone https://github.com/toannguyenitoz/active-directory-printer-troubleshooting.git
cd active-directory-printer-troubleshooting

# Review printer server health
.\scripts\Invoke-PrintServerHealthCheck.ps1 -ComputerName PRINT01

# Test a physical network printer
.\scripts\Test-NetworkPrinter.ps1 -IPAddress 10.20.30.40

# Preview creation of an AD-published shared queue
.\scripts\Add-TcpIpPrinter.ps1 `
  -PrinterName "ADL-L2-MFP01" `
  -IPAddress "10.20.30.40" `
  -DriverName "Universal Printing PCL 6" `
  -PublishInAD `
  -WhatIf
```

> [!CAUTION]
> Run destructive or service-impacting scripts with **`-WhatIf`** first. Review active jobs and business impact before restarting the Print Spooler or deleting queues, ports, drivers, driver packages or spool files.

## 📚 Documentation Library

| # | Guide | What You Will Learn |
|---:|---|---|
| 01 | [🏗️ Printing Architecture](docs/01-printing-architecture.md) | Clients, queues, ports, drivers, spooler, AD and GPO data flow |
| 02 | [🖥️ Build a Print Server](docs/02-build-a-print-server.md) | Install the role, validate services and enable event logging |
| 03 | [➕ Add, Share and Publish](docs/03-add-share-publish-printers.md) | Create ports and queues, share printers and publish to AD |
| 04 | [📦 Deploy with Group Policy](docs/04-deploy-printers-with-gpo.md) | User/computer deployment, targeting, removal and gpresult |
| 05 | [🔄 Remove, Replace and Migrate](docs/05-remove-replace-migrate-printers.md) | Safe retirement, replacement and print server migration |
| 06 | [🌐 Network Troubleshooting](docs/06-network-printer-troubleshooting.md) | IP, DNS, VLAN, firewall, RAW 9100 and connectivity faults |
| 07 | [🧯 Spooler, Queue and Driver Issues](docs/07-spooler-driver-and-queue-issues.md) | Stuck jobs, spooler crashes, driver isolation and logs |
| 08 | [🔐 Permissions and Point and Print](docs/08-permissions-security-and-point-and-print.md) | Queue ACLs, AD groups, driver restrictions and hardening |
| 09 | [⚡ PowerShell Administration](docs/09-powershell-administration.md) | Inventory, bulk changes, remote administration and testing |
| 10 | [🧪 Real-World Scenarios](docs/10-real-world-scenarios.md) | Seven practical enterprise troubleshooting scenarios |
| 11 | [🎧 Helpdesk Incident Runbook](docs/11-helpdesk-runbook.md) | Triage, evidence collection, escalation and closure notes |

## 🧪 Real-World Case Studies

The **Case Studies** section documents incidents encountered in real support work. Each case aims to show not only the final fix, but also the reasoning process, misleading symptoms, commands used, evidence collected, risk controls and lessons learned.

| Case | Incident | Environment | Key Finding | Status |
|---:|---|---|---|---|
| 01 | [👻 Ghost Kyocera Printer Reappears After Deletion](Case%20Studies/Case-01-Ghost-Kyocera-Printer.md) | Domain-joined Windows client, direct TCP/IP Kyocera printer | The local Kyocera driver stack was the effective cause domain; removing the unused driver stopped recurrence | ✅ Complete |

### Case 01 at a Glance

A Kyocera printer installed directly by IP returned within seconds after being deleted. The printer remained visible in Windows **Printers & scanners**, but neither `Get-Printer` nor `Win32_Printer` returned it. Because the machine was domain joined, GPO was initially suspected. Investigation showed no intentional print-server deployment, and removing the Kyocera driver stopped the printer from returning.

The detailed case includes:

- Environment and incident timeline.
- Why the GUI and PowerShell displayed different results.
- GPO, logon-script and deployment checks.
- Registry, printer-port and driver inspection.
- PrintService event-log collection.
- Safe driver and port removal procedures.
- Root-cause qualifications based on available evidence.
- Validation after spooler restart, sign-in, policy refresh and reboot.
- Evidence-collection script and ticket closure notes.
- Mermaid troubleshooting decision tree.

➡️ **[Read the complete Kyocera case study](Case%20Studies/Case-01-Ghost-Kyocera-Printer.md)**

### Planned Case Studies

| Planned Case | Topic |
|---:|---|
| 02 | Printer repeatedly mapped by Group Policy Preferences |
| 03 | Print Spooler crashes after a third-party driver update |
| 04 | Stale Driver Store package prevents clean reinstallation |
| 05 | TCP/IP printer shows Offline because of SNMP status mismatch |
| 06 | WSD printer changes ports after DHCP address changes |
| 07 | Shared printer fails after Point and Print hardening |
| 08 | User can see a printer but receives Access Denied when connecting |
| 09 | Old print server remains mapped after a migration |
| 10 | RDP redirected printers create duplicate queues |

## ⚙️ PowerShell Toolkit

See the complete [Scripts Catalogue](scripts/README.md).

| Script | Purpose |
|---|---|
| `Add-TcpIpPrinter.ps1` | Create a TCP/IP port and printer queue safely |
| `Remove-PrinterSafely.ps1` | Remove queues and optionally unused ports |
| `Repair-ClientPrinter.ps1` | Repair a client-side shared printer connection |
| `Reset-PrintSpooler.ps1` | Reset the Print Spooler with explicit safeguards |
| `Test-NetworkPrinter.ps1` | Test ping, TCP 9100 and printer reachability |
| `Get-PrinterInventory.ps1` | Export printer, port and driver inventory |
| `Find-StalePrinterQueues.ps1` | Identify unreachable or obsolete queues |
| `Get-PrinterEventLogs.ps1` | Collect relevant PrintService events |
| `Invoke-PrintServerHealthCheck.ps1` | Run consolidated print server health checks |
| `Export-PrintServerConfig.ps1` | Back up print server configuration |
| `Import-PrintServerConfig.ps1` | Restore or migrate exported configuration |

## 🔎 Quick Diagnostic Commands

```powershell
# Enumerate queues
Get-Printer | Format-Table Name, DriverName, PortName, Type -AutoSize

# Compare with the CIM printer provider
Get-CimInstance Win32_Printer |
    Format-Table Name, DriverName, PortName, Network, Local -AutoSize

# Review ports
Get-PrinterPort |
    Format-Table Name, PrinterHostAddress, PortNumber, SNMPEnabled -AutoSize

# Review drivers
Get-PrinterDriver |
    Format-Table Name, Manufacturer, MajorVersion, InfPath -AutoSize

# Test direct-IP printing connectivity
Test-NetConnection -ComputerName 10.20.30.40 -Port 9100

# Create a policy report
gpresult /h C:\Windows\Temp\Printer-GPResult.html /f
```

> [!TIP]
> When a printer is visible in Settings but absent from `Get-Printer`, compare queue data with CIM, registry, PnP devices, driver packages, WSD discovery and vendor utilities. Do not assume the GUI item is a healthy spooler queue.

## 🏷️ Recommended Naming Standard

```text
<SITE>-<FLOOR_OR_AREA>-<TYPE><NUMBER>
```

Examples: `ADL-L2-MFP01`, `ADL-RECEPTION-PRN01`, `MEL-WH-LABEL02`.

## 🗂️ Operational Templates

- [📝 Printer Change Request](templates/printer-change-request.md)
- [🎫 Troubleshooting Ticket Template](templates/troubleshooting-ticket-template.md)
- [📊 Printer Inventory CSV](templates/printer-inventory.csv)

## 🛡️ Supported Approach

This project favours:

- Least privilege.
- Signed and vendor-supported drivers.
- Approved Point and Print servers.
- Standardised printer naming and IP management.
- Change control for queue, port and driver changes.
- Evidence collection before destructive actions.
- Safe use of `-WhatIf` and explicit confirmation.
- Repeatable PowerShell automation.
- Root-cause statements that do not exceed the available evidence.

## 🗺️ Repository Roadmap

- Expand the real-world case-study library.
- Add vendor-specific guidance for Kyocera, HP, Canon, Brother and Zebra.
- Add Microsoft Universal Print and Intune deployment scenarios.
- Add printer-security and PrintNightmare hardening verification.
- Add driver-version audit and unsupported-driver reporting.
- Add a client-side ghost-printer evidence collector.
- Add screenshots and lab diagrams to each case.

## 🤝 Contributing

Contributions, issue reports and additional real-world scenarios are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) before submitting changes.

When documenting a new incident, use this structure:

```text
Incident Summary
Environment
Symptoms
Investigation
Commands and Evidence
Root Cause
Resolution
Validation
Preventive Actions
Lessons Learned
Ticket Closure Notes
```

## 📄 License

Released under the [MIT License](LICENSE).

---

<div align="center">

### 👨‍💻 Author

**Xuan Toan Nguyen**  
*IT Support • Systems Administration • Microsoft 365 • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

⭐ **Found this repository useful? Give it a star and share it with other IT professionals.**

[⬆ Back to Top](#top)

<sub>Made with ❤️ for the IT Support and Windows Administration community.</sub>

**#ToanNguyenITOz**

</div>
