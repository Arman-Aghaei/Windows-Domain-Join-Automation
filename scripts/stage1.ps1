##############################
# A-Z Join to Domain Script  #
# Author:      Arman Aghaei  #
# Version:              1.0  #
# Stage 1                    #
##############################

param(
    [Parameter(Mandatory = $true)]
    [string]$ComputerName,

    [Parameter(Mandatory = $true)]
    [string]$DomainName
)

$Stage2Path = "$PSScriptRoot\stage2.ps1"

##############################
# Stage 2 Preparation
##############################

$Action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$Stage2Path`" -DomainName `"$DomainName`""

$Trigger = New-ScheduledTaskTrigger -AtLogOn

Register-ScheduledTask `
    -TaskName Stage2-join `
    -Action $Action `
    -Trigger $Trigger `
    -RunLevel Highest `
    -Force

##############################
# Change Computer Name
##############################

Rename-Computer -NewName $ComputerName -Restart -Confirm
