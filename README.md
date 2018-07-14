# Centreon Server PowerShell Module

# Introduction

## Description

    Use Centreon API easily with Powershell

## Table of Contents

* [One Time Setup](#OneTimeSetup)
    * [Install](#Install)
    * [Permissions](#Permissions)
* [Get Started](#GetStarted)
    * [Available cmdlets](#AvailableCmds)
    * [List commands of the module](#ListCmds)
* [Configure connection](#Configure)
* [Resources](#Resources)


## One time Setup  
<a id="OneTimeSetup"></a> 

### Permissions
<a id="Permissions"></a>

* Enable Reach API Configuration and/or Reach API Realtime on the user. 
<a href="https://documentation.centreon.com/docs/centreon/en/latest/api/api_rest/index.html#permissions">(Centreon Permissions)</a>

### Install
<a id="Install"></a> 
Install the module from the PowerShell Gallery.

```powershell
Install-Module CentreonPS
```


## Get Started
<a id="GetStarted"></a> 

### List commands of the module
<a id="ListCmds"></a> 


```powershell
Get-Command -Module CentreonPS
```
### Available cmdlets
<a id="AvailableCmds"></a> 

|Functions | Descriptions |
|:------|:-----------|
| New-CentreonConnection | To connect to the Centreon Server|
| Get-CentreonHostStatus | Return the centreon hosts status in realtime|
| Get-CentreonServiceStatus | Return the centreon services status in realtime |
| Invoke-CentreonCommand | To manage the centreon objects (add,delete,set,show...) |

### Centreon Server Connection

<span style="color:red"> You have to re-do this step when the token has expired. </span>

#### Method 1 : Will request you, your centreon credentials 

```powershell
$Session = New-CentreonConnection -server "192.168.1.50"
```

#### Method 2 : Allow to specify your credentials 

```powershell
$Credentials = Get-Credential -UserName fclisson
$Session = New-CentreonConnection -server "192.168.0.30" -Credentials $Credentials
```

## How to use it

Invoke-CentreonCommand allow to manage any centreon object.

You have to specify the `object` that you want manage then which `action` you want do on it and lastly the value `values` expected.

Action and object list available from : <a href="https://documentation.centreon.com/docs/centreon/en/latest/api/clapi/objects/index.html">Centreon Clapi documentation</a>.

### Invoke Centreon(Clapi) Command

The following command line allow to add an Host to Centreon :
```powershell
 Invoke-CentreonCommand -Session $Session -object HOST -action ADD -Values "test;Test host;127.0.0.1;OS-Linux-SNMP-custom;central;Centreon_platform"
```

The following command line, allow to show the contact groups :
```powershell
 Invoke-CentreonCommand -Session $Session -object CG -action show
```

### Get Centreon Services

#### EXEMPLE
```powershell
Get-CentreonServiceStatus -Session $Session 
```

#### OUTPUT
```powershell

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

```

### Get Centreon Hosts

#### EXAMPLE 1
```powershell
Get-CentreonHostsStatus -Session $Session 
```

#### EXAMPLE 2
```powershell
Get-CentreonHostsStatus -Session $Session -status all -order ASC -search '%rsys%'
```

#### OUTPUT

```powershell

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

## Resources

* [Centreon API Documentation (https://documentation.centreon.com/docs/centreon/en/2.8.x/api/index.html)



## ToDo

- [ ] Not sure that the powershell plugin work with https,to try?
- [ ] Manage case when the token is expired
- [ ] Include authentification from default credentials (Active Directory Auth)
- [ ] Create Set-CentreonServerConfig?
- [ ] Create dynamic parameters on the Invoke-CentreonCommand function




