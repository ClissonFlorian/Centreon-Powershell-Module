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
- Download the repository
- Unblock the zip file
- Extract CentreonServer folder to a module path :
    - Local user :
        $env:USERPROFILE\Documents\WindowsPowerShell\Modules\)
    - All users :
        "C:\Program Files\WindowsPowerShell\Modules"
- **Allow user to use centreon API**
<a href="https://documentation.centreon.com/docs/centreon/en/latest/api/api_rest/index.html#permissions">(Centreon Permissions)</a>

### Import Module

```powershell
Import-Module CentreonServer.psd1  #Alternatively, Import-Module "\\Path\To\CentreonServer\CentreonServer.psd1"
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

Refer you to the <a href="https://documentation.centreon.com/docs/centreon/en/latest/api/clapi/objects/index.html">Centreon Clapi documentation</a> documentation Centreon Clapi according to the action you want to do.

### Run Centreon(Clapi) Command

The following command line, allow to add an Host to Centreon :
```powershell
 Run-CentreonCommand -Session $Session -object HOST -action ADD -Values "test;Test host;127.0.0.1;OS-Linux-SNMP-custom;central;Centreon_platform"
```

The following command line, allow to show the contact groups :
```powershell
 Run-CentreonCommand -Session $Session -object CG -action show
```



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

OUTPUT:

host_id                : 15
name                   : Centeon-central
description            : Broker-Retention
service_id             : 95
state                  : 0
state_type             : 1
output                 : OK: centreon-broker failover/temporary files are ok
                         Checking config '/etc/centreon-broker/central-rrd.xml'\nskipping temporary: no configuration set\nChecking config 
                         '/etc/centreon-broker/central-broker.xml'\nskipping temporary: no configuration set\n
perfdata               : 
max_check_attempts     : 3
check_attempt          : 1
last_check             : 1531062538
last_state_change      : 1528587027
last_hard_state_change : 1528587027
acknowledged           : 0
criticality            : 

#EXMPLE 2
Get-CentreonServiceStatus -Session $Session -status all -order ASC -search '%rsys%'
```


### Get Centreon Hosts
```powershell
#EXMPLE 1
Get-CentreonHostsStatus -Session $Session 

#EXMPLE 2
Get-CentreonHostsStatus -Session $Session -status all -order ASC -search '%rsys%'
```




## ToDo

- [ ] Not sure that the powershell plugin work with https,to try?
- [ ] Manage case when the token is expired
- [ ] Include authentification from default credentials (Active Directory Auth)
- [ ] Create Set-CentreonServerConfig?
