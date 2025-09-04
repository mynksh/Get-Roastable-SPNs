# Query AD via LDAP (no RSAT required) and print only roastable SPNs
$root   = [ADSI]"LDAP://RootDSE"
$baseDN = $root.defaultNamingContext

$ds = New-Object System.DirectoryServices.DirectorySearcher
$ds.SearchRoot = [ADSI]("LDAP://$baseDN")
$ds.Filter = "(servicePrincipalName=*)"
$ds.PageSize = 1000
@("sAMAccountName","servicePrincipalName","distinguishedName") | ForEach-Object { [void]$ds.PropertiesToLoad.Add($_) }

$rows = New-Object System.Collections.Generic.List[object]
foreach ($r in $ds.FindAll()) {
    $sam = ($r.Properties["samaccountname"] | Select-Object -First 1)
    if (-not $sam) { continue }
    if ($sam.ToString().EndsWith('$')) { continue }           # skip computers/gMSAs

    foreach ($spn in $r.Properties["serviceprincipalname"]) {
        $spn = $spn.ToString()
        if ($spn.StartsWith("HOST/") -or $spn.StartsWith("RestrictedKrbHost/")) { continue }  # skip noisy defaults
        $rows.Add([pscustomobject]@{
            SamAccountName    = $sam
            DistinguishedName = ($r.Properties["distinguishedname"] | Select-Object -First 1)
            SPN               = $spn
        })
    }
}

$rows | Sort-Object SamAccountName, SPN | Format-Table -AutoSize
# Optional: export for later
# $rows | Export-Csv -NoTypeInformation -Path roastable_spns.csv
