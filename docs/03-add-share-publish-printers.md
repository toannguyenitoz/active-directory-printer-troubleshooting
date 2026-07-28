<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# ➕ 03. Add, Share and Publish Printers

**Create ports, install queues, share printers and publish them in Active Directory.**

![Topic](https://img.shields.io/badge/Topic-Provisioning-22C55E?style=flat-square) ![Tool](https://img.shields.io/badge/Tools-Print_Management_|_PowerShell-5391FE?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](02-build-a-print-server.md) • [Next ➡](04-deploy-printers-with-gpo.md)

</div>

---

## 📋 Pre-Change Checklist

- Confirm model, serial number, location and business owner.
- Confirm IP, subnet, gateway, DNS and VLAN.
- Reserve the IP or assign it outside the client DHCP range.
- Download an approved signed driver from the vendor.
- Decide queue name, share name, location and AD groups.
- Test TCP 80/443 and 9100 from the print server.

## 🌐 Add a Standard TCP/IP Port

```powershell
$ip = '10.20.30.40'
$port = "IP_$ip"
Add-PrinterPort -Name $port -PrinterHostAddress $ip
```

For most office printers use **RAW TCP 9100**. Use LPR only where the vendor or legacy application specifically requires it.

## 🧩 Install or Validate the Driver

```powershell
Get-PrinterDriver | Sort-Object Name
Get-PrinterDriver -Name 'Universal Printing PCL 6'
```

Stage the vendor driver package first where required, then install the print driver by its exact Windows name.

## 🖨️ Create, Share and Publish the Queue

```powershell
Add-Printer `
  -Name 'ADL-L2-MFP01' `
  -DriverName 'Universal Printing PCL 6' `
  -PortName 'IP_10.20.30.40' `
  -Shared `
  -ShareName 'ADL-L2-MFP01' `
  -Published

Set-Printer `
  -Name 'ADL-L2-MFP01' `
  -Location 'Adelaide - Level 2' `
  -Comment 'Finance and Operations MFP'
```

Or preview the repository script:

```powershell
.\scripts\Add-TcpIpPrinter.ps1 `
  -PrinterName 'ADL-L2-MFP01' `
  -IPAddress '10.20.30.40' `
  -DriverName 'Universal Printing PCL 6' `
  -Location 'Adelaide - Level 2' `
  -PublishInAD `
  -WhatIf
```

## 🔐 Configure Permissions

Recommended groups:

```text
GG-PRN-ADL-L2-MFP01-USERS
GG-PRN-ADL-L2-MFP01-OPERATORS
GG-PRINT-SERVER-ADMINS
```

Assign **Print** to users, **Manage Documents** to approved operators, and **Manage This Printer** only to print administrators.

## ✅ Validation

1. Print a server test page.
2. Open the printer web interface and confirm the job arrives.
3. Connect from a standard domain client using `\\PRINT01\ADL-L2-MFP01`.
4. Test from Notepad and a business application.
5. Confirm AD search and GPO targeting.
6. Record queue, port, driver and ownership in inventory.

> [!WARNING]
> Do not use a generic driver merely because it installs successfully. Validate duplex, colour, trays, secure print, stapling and application compatibility.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
