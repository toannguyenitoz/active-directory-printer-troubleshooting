<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# 🌐 06. Network Printer Troubleshooting

**Diagnose IP, DNS, VLAN, firewall, port and device connectivity issues.**

![Topic](https://img.shields.io/badge/Topic-Network_Diagnostics-0EA5E9?style=flat-square) ![Protocols](https://img.shields.io/badge/Protocols-80_|_443_|_515_|_9100-22C55E?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](05-remove-replace-migrate-printers.md) • [Next ➡](07-spooler-driver-and-queue-issues.md)

</div>

---

## 🧭 Start with Scope

Determine whether the issue affects:

- One user.
- One workstation.
- One application.
- One queue.
- One physical printer.
- Multiple printers on the same server.
- An entire site or VLAN.

Scope tells you whether to begin at the client, print server, network or physical device.

## 🔍 Connectivity Tests

```powershell
Test-Connection 10.20.30.40 -Count 2
Test-NetConnection 10.20.30.40 -Port 80
Test-NetConnection 10.20.30.40 -Port 443
Test-NetConnection 10.20.30.40 -Port 515
Test-NetConnection 10.20.30.40 -Port 9100
```

Repository helper:

```powershell
.\scripts\Test-NetworkPrinter.ps1 -IPAddress 10.20.30.40
```

### Interpret Results

| Result | Likely Meaning |
|---|---|
| Ping fails, web and 9100 fail | Device powered off, wrong IP, VLAN/ACL issue or route failure. |
| Ping fails but 9100 works | ICMP is blocked; printing may still work. |
| Web works but 9100 fails | RAW printing disabled, firewall block or wrong protocol. |
| Server reaches printer but clients do not | Normal when clients print through the server; test TCP 445 to server. |
| Intermittent results | Duplicate IP, unstable switch port, Wi-Fi bridge or device sleep issue. |

## 🧩 Validate Queue and Port

```powershell
Get-Printer -Name 'ADL-L2-MFP01' | Format-List *
Get-PrinterPort -Name 'IP_10.20.30.40' | Format-List *
```

Confirm:

- The queue points to the correct port.
- The port contains the current printer IP.
- Protocol is RAW 9100 or the approved LPR queue.
- SNMP settings match device capability.
- No second device is using the same IP.

## 🌍 DNS and Address Management

Printers are often more reliable with DHCP reservations. Record the MAC address, reservation, hostname, site and asset number. Flush stale records after authorised changes:

```powershell
Resolve-DnsName ADL-L2-MFP01
arp -a
ipconfig /flushdns
```

## 🧱 VLAN and Firewall Checks

Verify routes and ACLs between:

- Print server subnet and printer VLAN.
- Admin workstation and printer management interface.
- Client subnet and print server TCP 445.
- Monitoring platform and SNMP where used.

Do not open broad network access when only the print server requires printer connectivity.

## 🖨️ Physical Device Checks

- Power, cable and switch link.
- Paper, toner, jams and door sensors.
- Printer panel error code.
- IP configuration page.
- Sleep or energy-saving behaviour.
- Firmware health and storage capacity.

> [!TIP]
> A successful ping does not prove printing works. Test the exact service port and send a server test page.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
