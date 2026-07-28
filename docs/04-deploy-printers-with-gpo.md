<a id="top"></a>

<div align="center">

[![Repository Header](../images/repository-header.svg)](../README.md)

# 📦 04. Deploy Printers with Group Policy

**Deploy, update and remove shared printers by user, computer, OU or security group.**

![Topic](https://img.shields.io/badge/Topic-Group_Policy-2F5BB7?style=flat-square) ![Scope](https://img.shields.io/badge/Scope-User_|_Computer-8B5CF6?style=flat-square)

[🏠 Home](../README.md) • [📚 Documentation](README.md) • [⬅ Previous](03-add-share-publish-printers.md) • [Next ➡](05-remove-replace-migrate-printers.md)

</div>

---

## 🎯 Choose the Correct Scope

| Deployment | Best Use |
|---|---|
| User Configuration | The printer should follow a user between workstations. |
| Computer Configuration | The printer belongs to a room, kiosk, lab or shared workstation. |
| Security Group Targeting | Access is based on department or job function. |
| Site or OU Targeting | Deployment follows physical location or device ownership. |

## 🧭 Group Policy Preferences Path

```text
User Configuration
└─ Preferences
   └─ Control Panel Settings
      └─ Printers
```

or:

```text
Computer Configuration
└─ Preferences
   └─ Control Panel Settings
      └─ Printers
```

Create a **Shared Printer** item and use the UNC path:

```text
\\PRINT01\ADL-L2-MFP01
```

## ⚙️ Preference Actions

| Action | Behaviour |
|---|---|
| Create | Adds the connection if it does not exist. |
| Update | Creates it if missing and updates supported settings. |
| Replace | Deletes and recreates it at each policy refresh. Use carefully. |
| Delete | Removes the connection. |

> [!TIP]
> **Update** is normally the safest ongoing action. Use **Replace** only when you understand the user impact and reconnection behaviour.

## 🎯 Item-Level Targeting

Common conditions include:

- Security group membership.
- Computer name or OU.
- IP address range or AD site.
- Operating system.
- Laptop, desktop or terminal server role.

Example group:

```text
GG-PRN-ADL-L2-MFP01-USERS
```

## 🔄 Apply and Diagnose Policy

```powershell
gpupdate /force
gpresult /r
gpresult /h C:\Temp\gpresult-printer.html
Get-Printer
```

Check:

1. The GPO is linked to the correct OU.
2. Security filtering includes the user or computer.
3. Item-level targeting evaluates as expected.
4. The UNC path is correct and reachable on TCP 445.
5. The user has queue permission.
6. Point and Print policy permits the approved server and driver.
7. Loopback processing is understood on RDS or shared devices.

## 🗑️ Remove a Deployed Printer

1. Change the preference action to **Delete**, preserving the same UNC path and targeting.
2. Allow policy to apply to affected users or computers.
3. Confirm the connection is removed.
4. Remove the old preference item only after the retirement window.

This avoids a printer being manually removed and then returning at the next policy refresh.

## ✅ Validation Matrix

Test at least one user or workstation that should receive the printer and one that should not. Verify mapping, default printer behaviour, printing, permissions, event logs and removal.

---

<div align="center">

### 👨‍💻 Author
**Xuan Toan Nguyen** — *IT Support • Systems Administration • Windows Server*  
📍 Adelaide, South Australia

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/toan-nguyen-it-oz) [![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/toannguyenitoz)

[⬆ Back to Top](#top) • [🏠 Repository Home](../README.md)  
**#ToanNguyenITOz**

</div>
