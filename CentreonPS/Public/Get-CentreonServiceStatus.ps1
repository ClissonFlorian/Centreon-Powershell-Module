function Get-CentreonServiceStatus{
<#
    .SYNOPSIS
        Retrieve services status information.
    .DESCRIPTION
        All monitoring information regarding services are available in throw the Centreon API. 
        With this call, you can also get host informations in the same time that service information. 
        This web service provide the same possibility that the service monitoring view.
    .PARAMETER Session
        Specify object get from New-CentreonCommand cmdlet.
    .PARAMETER viewType
        Select monitoring view type.
        Values accepted: "all", "unhandled", "problems"
        Default is 'all'.
    .PARAMETER fields
        Select-Object separated by a ','.
    .PARAMETER status
        Select services by status.
        Values accepted: "ok", "warning", "critical", "unknown", "pending", "all"
        Default is 'all'.

    .PARAMETER hostgroup
        Hostgroup id to filter.
    .PARAMETER servicegroup
        Servicegroup id filter.
    .PARAMETER instance
        Instance id filter.
    .PARAMETER search
         Search by name of service via an SQL LIKE type search..
    .PARAMETER searchHost
         Search by name of host via an SQL LIKE type search.
    .PARAMETER searchOutput
         Search by output via an SQL LIKE type search.
    .PARAMETER criticality
        Criticality Filter.
    .PARAMETER sortType
        Sort by field.
    .PARAMETER limit
        Number of object return.
    .PARAMETER number
        Page number.
    .PARAMETER order
        Sort objects return.
        Values accepted: "ASC", "DESC".
        Default is 'ASC'.
    .EXAMPLE
        Get-CentreonServiceStatus -status all -order ASC -Session $Session  -fields description
    .EXAMPLE
        Get-CentreonServiceStatus -status all -order ASC -Session $Session -search '%rsys%'
    .LINK
        https://documentation.centreon.com/docs/centreon/en/latest/api/api_rest/index.html#service-status
    .NOTES
        https://github.com/ClissonFlorian/Centreon-Powershell-Module
#>
    
    param(
        
        [parameter(Mandatory = $true)]
        [object]$Session,

        [parameter(Mandatory = $false)]
        [ValidateSet("all", "unhandled", "problems")][string]$viewType = "all",

        [parameter(Mandatory = $false)]
        [array]$fields,
        
        [parameter(Mandatory = $false)]
        [ValidateSet("ok", "warning", "critical", "unknown", "pending", "all")][string]$status = "all",

        [parameter(Mandatory = $false)]
        [int]$hostgroup,

        [parameter(Mandatory = $false)]
        [int]$servicegroup,

        [parameter(Mandatory = $false)]
        [int]$instance,

        [parameter(Mandatory = $false)]
        [string]$search,

        [parameter(Mandatory = $false)]
        [string]$searchHost,

        [parameter(Mandatory = $false)]
        [string]$searchOutput,

        [parameter(Mandatory = $false)]
        [string]$criticality,

        [parameter(Mandatory = $false)]
        [string]$sortType,

        [parameter(Mandatory = $false)]
        [int]$limit,

        [parameter(Mandatory = $false)]
        [int]$number,

        [parameter(Mandatory = $false)]
        [ValidateSet("ASC", "DESC")][string]$order = "ASC"   
    )

    $options = @()
    #get function name and arguments
    (Get-Command ($MyInvocation.MyCommand).Name).parameters.Keys | Where-Object {$_ -notmatch "token|url"} | ForEach-Object {

        $ValueFromVariable = Get-Variable $_ -ErrorAction SilentlyContinue   
        $option = ($ValueFromVariable).Name
        $value = ($ValueFromVariable).Value
       
        if ($value) {
        
            $options += ("$option" + "=" + "$value")
        }
    }

    $cmdline = "object=centreon_realtime_services&action=list"
   
    $options = $options -join "&"
    
    $query = "$cmdline&$options" 

    try {
       
        $output = (Invoke-WebRequest -ContentType "application/json" -Uri "$($Session.url)$query" -Method Get -Headers $($Session.token)).Content | ConvertFrom-Json
        return $output
    }
    catch {
       
        Write-host $Error[0] -ForegroundColor Red
    }
}