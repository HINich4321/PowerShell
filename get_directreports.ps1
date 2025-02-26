$ManagerName = "JohnDoe"

function Get-AllReports {  
    param(  
        [string]$Manager  
    )   
    $DirectReports = Get-ADUser -Filter {manager -eq $Manager}  
    if($DirectReports){  
        Write-Output $DirectReports  
        $DirectReports | ForEach-Object {  
            Get-AllReports -Manager $_.DistinguishedName  
        } 
    }  
} 
   
Get-AllReports -Manager $ManagerName  | sort-object manager | format-table Name, UserPrincipalName
#optional if you want it in a csv format
#| export-csv -path "Path\list.csv" -NoTypeInformation 
