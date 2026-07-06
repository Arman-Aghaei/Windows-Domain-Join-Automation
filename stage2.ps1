##############################
# A-Z Join to Domain Script  #
# Author:      Arman Aghaei  #
# Version:              1.0  #
# Stage 2                    #
##############################

param(
    [Parameter(Mandatory = $true)]
    [string]$DomainName
)

$Credential = Get-Credential
$Stage3Path = "$PSScriptRoot\stage3.ps1"

##############################
# Show Description
##############################

Write-Host "Stage 2 started" -ForegroundColor DarkBlue
Write-Host "DomainName Received: $DomainName" -ForegroundColor DarkGreen
Write-Host "Current ComputerName: $env:COMPUTERNAME" -ForegroundColor DarkYellow
Write-Host "New FQDN: $env:COMPUTERNAME.$DomainName"

##############################
# Stage 3 Preparation
##############################

$Action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$Stage3Path`""

$Trigger = New-ScheduledTaskTrigger -AtLogOn

Register-ScheduledTask `
    -TaskName "Stage3-Finalize" `
    -Action $Action `
    -Trigger $Trigger `
    -RunLevel Highest `
    -Force

##############################
# Join to Domain
##############################

try {
    Add-Computer -DomainName $DomainName -Credential $Credential -ErrorAction Stop

    Write-Host "Domain join completed successfully." -ForegroundColor Green
    Write-Host "Restart manually to continue to Stage 3." -ForegroundColor Yellow
}
catch {
    Write-Host "Domain join failed." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Unregister-ScheduledTask -TaskName "Stage2-join" -ErrorAction SilentlyContinue

Write-Host "Press any key to continue..."
[System.Console]::ReadKey($true) | Out-Null

Restart-Computer