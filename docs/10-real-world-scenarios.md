<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# 🧪 10. Real-World Troubleshooting Scenarios

**Practical incident patterns for Helpdesk, Desktop Support and Systems Administrators.**

![Topic](https://img.shields.io/badge/Topic-Incident_Scenarios-8B5CF6?style=flat-square) ![Approach](https://img.shields.io/badge/Approach-Scope_|_Evidence_|_Validate-22C55E?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](09-powershell-administration.md) • [Next ➡](11-helpdesk-runbook.md)

</div>

---

## 👤 Scenario 1: One User Cannot Print

**Likely area:** client mapping, profile, permissions or application.

1. Confirm the correct printer is selected.
2. Test from Notepad to rule out application-specific failure.
3. Review the user's local print jobs.
4. Remove and reconnect the shared printer.
5. Compare with another user on the same PC.
6. Verify queue permissions and group membership.
7. Review the client PrintService log.

```powershell
.\scripts\Repair-ClientPrinter.ps1 -ConnectionName '\\PRINT01\ADL-L2-MFP01' -WhatIf
```

## 🖨️ Scenario 2: Everyone Fails on One Printer

**Likely area:** device, IP, port, queue or hardware state.

- Open the printer web interface.
- Test TCP 9100.
- Check paper, toner, jam and panel errors.
- Validate queue pause/offline status.
- Confirm the queue port uses the current IP.
- Send a server test page.
- Restart the physical device only when operationally safe.

## 🖥️ Scenario 3: Every Printer on One Server Fails

**Likely area:** Spooler, server health, storage, network or recent driver change.

```powershell
Get-Service Spooler
Get-PSDrive C
Get-WinEvent -LogName System -MaxEvents 100
.\scripts\Invoke-PrintServerHealthCheck.ps1 -ComputerName PRINT01
```

Identify recent patches, driver changes and spooler crash events before restarting services.

## 🚫 Scenario 4: Access Denied While Connecting

1. Verify the queue is shared.
2. Check **Print** permission.
3. Confirm the user is in the correct AD group.
4. Sign out and back in after new group membership.
5. Test TCP 445 to the print server.
6. Review Point and Print GPO settings.
7. Generate `gpresult` evidence.

## 🔣 Scenario 5: Random Characters or Blank Pages

**Likely cause:** wrong driver, printer language or print processor.

- Compare PCL and PostScript support.
- Test the approved universal driver.
- Validate RAW/LPR port configuration.
- Remove the corrupt job.
- Test a simple Notepad page before a complex PDF.
- Update firmware only through approved change control.

## ♻️ Scenario 6: Removed Printer Keeps Returning

**Likely cause:** GPO Preferences, logon script or endpoint management.

```powershell
gpresult /h C:\Temp\gpresult-printer.html
gpupdate /force
```

Find the deployment source, change the matching item to **Delete**, verify item-level targeting, then retest after policy refresh and sign-in.

## 🐌 Scenario 7: Printing Is Very Slow

Investigate:

- Document size and complexity.
- Application-specific rendering.
- Server CPU, RAM, disk and spool folder.
- Network latency and packet loss.
- Driver rendering mode.
- Printer storage and firmware.
- Secure print, finishing and advanced options.
- Whether the delay occurs before spooling, on the server or at the device.

## ✅ Incident Method

For every case document:

1. **Scope** — users, devices, queues, applications and locations affected.
2. **Evidence** — exact errors, timestamps, logs, tests and recent changes.
3. **Hypothesis** — client, server, network, policy, driver or hardware.
4. **Controlled action** — smallest safe change first.
5. **Validation** — server test, client test and user confirmation.
6. **Prevention** — inventory, reservation, driver, monitoring or documentation update.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
