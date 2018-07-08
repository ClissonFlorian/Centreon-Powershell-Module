# Centreon Server PowerShell Module

# Introduction

## Description

    Use the Centreon API easily with Powershell

## Functions Available

|Function | Description |
|:------|:-----------|
| **New-CentreonConnection** | To connect to the Centreon Server|
| **Get-CentreonHostStatus**| Return the centreon hosts status in realtime|
| **Get-CentreonServiceStatus**| Return the centreon services status in realtime |
| **Run-CentreonCommand**   | To manage the centreon objects (add,delete,set,show) |


## Description    

## One time setup

### Download and Unzip package
 * Download the repository
 * Unblock the zip file
 * Extract CentreonServer folder to a module path 
    * Local user
        *   (e.g. $env:USERPROFILE\Documents\WindowsPowerShell\Modules\)
    * All users
        *   (e.g. "C:\Program Files\WindowsPowerShell\Modules")

### Import Module

```powershell
    Import-Module CentreonServer  #Alternatively, Import-Module "\\Path\To\CentreonServer"
```

## Quick Start

### Open connection to Centreon Server
```powershell
    $Session = New-SSConnection -server 192.168.1.50
```

### Open connection to Centreon Server
```powershell
   Get-ServiceStatus -Session $Session 
```

## How to use it

### List commands of the module
```powershell
Get-Command -Module CentreonServer
```
   
##Changelog

## ToDo

