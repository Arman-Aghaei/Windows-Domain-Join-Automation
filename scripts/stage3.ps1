##############################
# A-Z Join to Domain Script  #
# Author:      Arman Aghaei  #
# Version:              1.0  #
# Stage 3                    #
##############################

##############################
# Fix Time
##############################

w32tm /config /syncfromflags:domhier /update
w32tm /resync

Set-TimeZone -Id "Iran Standard Time"

##############################
# Add Language
##############################

Write-Host "Do you want to add Persian language? (y/n): " -NoNewline
$Key = [System.Console]::ReadKey($true)

$Answer = $Key.KeyChar
Write-Host $Answer

if ($Answer -eq "y" -or $Answer -eq "Y") 
{

    $LanguageList = Get-WinUserLanguageList

    if ($LanguageList.LanguageTag -contains "fa-IR" -or $LanguageList.LanguageTag -contains "fa") 
    {
        Write-Host "Persian language already exists"
    }
    else {
        $LanguageList.add("fa-IR")
        Set-WinUserLanguageList -LanguageList $LanguageList -Force
        Write-Host "Persian language added" -ForegroundColor Green
    }

}
else {
    Write-Host "Skipping Persian language."
}


##############################
# Cleanup Scheduled Tasks
##############################

Unregister-ScheduledTask -TaskName "Stage2-join" -Confirm:$false -ErrorAction SilentlyContinue
Unregister-ScheduledTask -TaskName "Stage3-Finalize" -Confirm:$false -ErrorAction SilentlyContinue

##############################
# Finish
##############################

Write-Host "Stage 3 completed." -ForegroundColor Green
Write-host "Operation Completed Successfully" -ForegroundColor White
