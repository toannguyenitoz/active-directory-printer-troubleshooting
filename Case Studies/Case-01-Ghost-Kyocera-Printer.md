# Case Study 01 – Ghost Kyocera Printer Reappears After Deletion

## Symptoms
- Windows device joined to Active Directory.
- Kyocera printer installed directly using a Standard TCP/IP Port.
- Printer reappears within seconds after being deleted.
- `Get-Printer` and `Get-CimInstance Win32_Printer` do not list the printer.
- Printer is still visible in Control Panel.

## Investigation
- Confirmed printer was **not** deployed by GPO.
- Confirmed printer was **not** deployed from a Print Server.
- Printer was installed locally via TCP/IP.
- Removing the printer queue alone did not resolve the issue.
- Removing the Kyocera printer driver stopped the printer from reappearing.

## Root Cause
The installed Kyocera KX driver/port monitor recreated the printer automatically, resulting in a ghost printer.

## Resolution
1. Remove the printer.
2. Remove the Kyocera driver from Print Management.
3. Restart the Print Spooler.
4. Reinstall the latest Kyocera KX driver only if required.

## Lessons Learned
Before blaming Active Directory or Group Policy, always verify printer drivers, vendor utilities, port monitors and the Print Spooler. In this case the root cause was the local Kyocera driver, not Active Directory or GPO.
