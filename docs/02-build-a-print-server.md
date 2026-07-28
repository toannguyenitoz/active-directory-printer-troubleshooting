<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# 🖥️ 02. Build a Windows Print Server

**Install, validate and baseline a domain print server.**

![Windows Server](https://img.shields.io/badge/Windows_Server-2019_|_2022_|_2025-0078D4?style=flat-square&logo=windows&logoColor=white) ![Role](https://img.shields.io/badge/Role-Print_Server-8B5CF6?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](01-printing-architecture.md) • [Next ➡](03-add-share-publish-printers.md)

</div>

---

## ✅ Prerequisites

- Domain-joined Windows Server with a static IP.
- Current security updates and verified DNS registration.
- Administrative access and an approved change record.
- Printer IP addresses, models, locations and approved drivers.
- Firewall access to printers and client access to the server.

## 📦 Install the Role

### Server Manager

1. Open **Server Manager**.
2. Select **Add roles and features**.
3. Choose **Role-based or feature-based installation**.
4. Select the server.
5. Enable **Print and Document Services → Print Server**.
6. Complete installation and restart only if requested.

### PowerShell

```powershell
Install-WindowsFeature Print-Server -IncludeManagementTools
```

## 🔍 Validate the Baseline

```powershell
Get-WindowsFeature Print-Server
Get-Service Spooler
Get-Printer
Get-PrinterPort
Get-PrinterDriver
```

Expected results:

- `Print-Server` is installed.
- `Spooler` is running and configured for automatic startup.
- No unexpected legacy drivers or queues exist.

## 🧰 Management Consoles

```text
printmanagement.msc
services.msc
eventvwr.msc
```

Important Print Management nodes include **Drivers**, **Ports**, **Printers**, **Forms** and **Deployed Printers**.

## 📋 Enable Operational Logging

```powershell
wevtutil sl Microsoft-Windows-PrintService/Operational /e:true

Get-WinEvent -LogName 'Microsoft-Windows-PrintService/Admin' -MaxEvents 20
Get-WinEvent -LogName 'Microsoft-Windows-PrintService/Operational' -MaxEvents 20
```

## 🛡️ Recommended Hardening

- Patch the server before adding queues.
- Restrict local administrator membership.
- Use signed and supported drivers.
- Back up configuration using `PrintBrm.exe`.
- Monitor free disk space and spool directory growth.
- Do not install unrelated applications on the print server.
- Disable the Spooler on servers that do not require printing.

## 🧪 Acceptance Test

1. Confirm DNS resolution from a domain client.
2. Confirm TCP 445 connectivity to the server.
3. Add a test queue and print a server test page.
4. Connect from a standard user workstation.
5. Review PrintService logs for errors.
6. Export the baseline configuration and inventory.

> [!IMPORTANT]
> Establish a clean baseline before production deployment. This makes later driver, queue and policy troubleshooting significantly easier.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
