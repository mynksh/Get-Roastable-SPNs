# Get-Roastable-SPNs

A lightweight PowerShell script to enumerate **roastable Service Principal Names (SPNs)** from Active Directory.  
This script uses pure LDAP queries — **no RSAT / ActiveDirectory module required**.

---

## 🔎 Features

- ✅ Enumerates all accounts with SPNs in the domain
- ✅ Filters out:
  - Computer accounts (`sAMAccountName` ending in `$`)
  - Managed service accounts (gMSA)
  - Default SPNs (`HOST/`, `RestrictedKrbHost/`)
- ✅ Outputs clean table of only **roastable user accounts**
- ✅ Option to export results to CSV for later cracking / analysis

---

## 💻 Usage

Clone or download the script:

```powershell
git clone https://github.com/mynksh/Get-Roastable-SPNs.git
cd Get-Roastable-SPNs
powershell -ep bypass -File .\get-roastable-spns.ps1
