<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# 🏗️ 01. Printing Architecture in Active Directory

**Understand the complete path from a user application to the physical printer.**

![Topic](https://img.shields.io/badge/Topic-Architecture-0078D4?style=flat-square) ![Level](https://img.shields.io/badge/Level-Foundation-22C55E?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [Next ➡](02-build-a-print-server.md)

</div>

---

## 🧩 Main Components

| Component | Purpose |
|---|---|
| Physical printer or MFP | Produces output and normally uses a static IP or DHCP reservation. |
| Print server | Hosts queues, ports, drivers, permissions and shared names. |
| Print queue | Accepts jobs and forwards them through the assigned port. |
| Standard TCP/IP port | Defines the target IP and protocol, commonly RAW TCP 9100. |
| Driver | Converts the Windows job into PCL, PostScript or vendor-specific output. |
| Print Spooler | Queues and processes jobs on clients and servers. |
| Active Directory | Makes published queues searchable and supports delegated access. |
| Group Policy | Adds, updates or removes printer connections centrally. |

## 🔄 Typical Data Flow

```text
Application
   ↓
Client Print Spooler
   ↓
\\PRINT01\ADL-L2-MFP01
   ↓
Print Server Queue + Driver
   ↓
Standard TCP/IP Port
   ↓
10.20.30.40:9100
   ↓
Physical Printer
```

## ⚖️ Direct IP vs Shared Queue

### Direct IP Printing

**Advantages:** simple for very small environments and independent of a print server.

**Disadvantages:** duplicated drivers, inconsistent configuration, difficult auditing, and every endpoint must be updated when an IP or device changes.

### Print Server Printing

**Advantages:** central naming, permissions, driver control, GPO deployment, auditing and easier replacement.

**Disadvantages:** the server and Spooler are shared dependencies; a faulty driver can affect several queues.

## ✅ Recommended Enterprise Pattern

- Use a dedicated domain-joined member server such as `PRINT01`.
- Assign DHCP reservations or static addresses outside client pools.
- Use consistent queue, share and port names.
- Publish user-facing queues in AD.
- Deploy by site, department, OU or security group.
- Prefer signed, package-aware, vendor-supported universal drivers.
- Isolate specialist label, plotter or legacy drivers where possible.
- Monitor PrintService logs and retain a current inventory.

> [!TIP]
> Keeping the **same share name** during physical printer replacement avoids remapping every client. Change the queue's port and driver only after testing.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
