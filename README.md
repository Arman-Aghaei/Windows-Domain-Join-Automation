# Windows Domain Join Automation

A multi-stage PowerShell automation project for preparing Windows client machines, renaming them, joining them to an Active Directory domain, and applying basic post-join configuration.

## Overview

This project automates a common Windows administration workflow:

1. Rename the computer
2. Restart the system
3. Join the computer to an Active Directory domain
4. Restart again
5. Apply post-join configuration such as time synchronization, time zone configuration, optional Persian language setup, and scheduled task cleanup

The script is split into multiple stages because some Windows configuration steps require restart and logon continuation.

## Features

- Computer rename before domain join
- Multi-stage execution using Windows Scheduled Tasks
- Active Directory domain join using secure credential prompt
- Automatic restart between stages
- Domain hierarchy time synchronization
- Iran time zone configuration
- Optional Persian language setup
- Cleanup of temporary scheduled tasks after completion
- Simple batch launcher for easier execution

## Project Structure

```text
Windows-Domain-Join-Automation/
├── README.md
├── Run.bat
├── stage1.ps1
├── stage2.ps1
└── stage3.ps1
