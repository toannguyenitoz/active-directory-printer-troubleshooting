<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# 🔐 08. Permissions, Security and Point and Print

**Apply least privilege, resolve access errors and manage driver installation securely.**

![Topic](https://img.shields.io/badge/Topic-Security-DC2626?style=flat-square) ![Principle](https://img.shields.io/badge/Principle-Least_Privilege-22C55E?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](07-spooler-driver-and-queue-issues.md) • [Next ➡](09-powershell-administration.md)

</div>

---

## 🧾 Printer Permissions

| Permission | Capability |
|---|---|
| Print | Connect and submit personal print jobs. |
| Manage Documents | Pause, resume, restart or cancel all users' jobs. |
| Manage This Printer | Change queue configuration, sharing and permissions. |

## 👥 Recommended AD Groups

```text
GG-PRN-ADL-L2-MFP01-USERS
GG-PRN-ADL-L2-MFP01-OPERATORS
GG-PRINT-SERVER-ADMINS
```

Use groups rather than assigning individuals directly. Document group owners and approval requirements.

## 🚫 Access Denied When Connecting

Check in this order:

1. The UNC path and share name are correct.
2. The queue is shared and online.
3. The user has **Print** permission.
4. The client reaches the print server on TCP 445.
5. Domain authentication and time synchronisation are healthy.
6. New group membership has entered the user's logon token.
7. Driver installation is allowed by policy.
8. The print server is included in approved Point and Print settings.

```powershell
Test-NetConnection PRINT01 -Port 445
gpresult /h C:\Temp\gpresult-printer.html
whoami /groups
```

## 🛡️ Point and Print

Modern Windows restricts printer driver installation because drivers can execute with elevated privilege.

Recommended controls:

- Use patched and trusted print servers.
- Deploy signed, package-aware drivers.
- Limit approved Point and Print servers.
- Pre-stage drivers through endpoint management where appropriate.
- Avoid broad registry or GPO changes that suppress elevation permanently.
- Test security changes with standard users before production rollout.

Relevant GPO path:

```text
Computer Configuration
└─ Administrative Templates
   └─ Printers
```

Review settings for:

- Package Point and Print – Approved Servers.
- Point and Print Restrictions.
- Driver installation restrictions.
- Spooler client connection policies.

## 🧨 Print Spooler Attack Surface

The Spooler should run only where printing is required. On servers that do not print:

```powershell
Stop-Service Spooler
Set-Service Spooler -StartupType Disabled
```

> [!WARNING]
> Never run these commands on an active print server, RDS host or application server that requires printing without an approved impact assessment.

## ✅ Security Review Checklist

- Queue ACLs use AD groups.
- Administrative permissions are limited.
- Drivers are signed and supported.
- Server and clients are patched.
- Unused queues, drivers and ports are removed through change control.
- Logs are retained for investigations.
- GPOs reference only approved servers.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
