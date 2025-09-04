# Get-Roastable-SPNs
PowerShell script to enumerate roastable SPNs in Active Directory without requiring RSAT tools. Filters out computer accounts ($) and default SPNs (HOST/, RestrictedKrbHost/), leaving only user service accounts that are potential Kerberoast targets.
