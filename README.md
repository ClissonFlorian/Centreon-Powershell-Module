# Centreon Server PowerShell Module

# Introduction

## Description

    Use Centreon API easily with Powershell

## Available Functions 

|Function | Description |
|:------|:-----------|
| **New-CentreonConnection** | To connect to the Centreon Server|
| **Get-CentreonHostStatus**| Return the centreon hosts status in realtime|
| **Get-CentreonServiceStatus**| Return the centreon services status in realtime |
| **Run-CentreonCommand**   | To manage the centreon objects (add,delete,set,show) |
   

## One time setup

### Download and Unzip package
Download the repository
Unblock the zip file
Extract CentreonServer folder to a module path :
- Local user
        $env:USERPROFILE\Documents\WindowsPowerShell\Modules\)
- All users
        "C:\Program Files\WindowsPowerShell\Modules"

### Import Module

```powershell
Import-Module CentreonServer  #Alternatively, Import-Module "\\Path\To\CentreonServer"
```

## Quick Start

### List commands of the module
```powershell
Get-Command -Module CentreonServer
```

### Centreon Server Connection

#METHODE 1 : Will request you, your centreon credentials 
```powershell
$Session = New-CentreonConnection -server 192.168.1.50
```

#METHODE 2 : Allow to specify your credentials 
```powershell
$Credentials = Get-Credential -UserName fclisson
$Session = New-CentreonConnection -server 192.168.0.30 -Credentials $Credentials
```

## How to use it

### Get Centreon Hosts
```powershell
   #EXMPLE 1
   Get-CentreonHostStatus -Session $Session 

   OUTPUT:

    id                     : 15
    name                   : Centeon-central
    alias                  : Centreon central server
    address                : 127.0.0.1
    state                  : 0
    state_type             : 1
    output                 : OK - 127.0.0.1: rta 0.025ms, lost 0%
    max_check_attempts     : 3
    check_attempt          : 1
    last_check             : 1531060693
    last_state_change      : 1528586735
    last_hard_state_change : 1528586735
    acknowledged           : 0
    instance_name          : Central
    criticality            :
```

### Get Centreon Services
```powershell
#EXMPLE 1
Get-CentreonServiceStatus -Session $Session 

#EXMPLE 2
Get-CentreonServiceStatus -Session $Session -status all -order ASC  -search '%rsys%'
```

### Run Centreon(Clapi) Command

Report you to the  <a href="https://documentation.centreon.com/docs/centreon/en/latest/api/clapi/objects/index.html">Centreon Clapi documentation</a> according the action that you want to do:


```powershell
 Run-CentreonCommand -Session $Session -object HOST -action ADD -Values "test;Test host;127.0.0.1;OS-Linux-SNMP-custom;central;Centreon_platform"
```

## ToDo

- [ ] Not sure that the plugins work with https
- [ ] Manage case when the token is expired
- [ ] Include authentification from default credentials (Active Directory Auth)
- [ ] Create-Set-CentreonConfig ?
