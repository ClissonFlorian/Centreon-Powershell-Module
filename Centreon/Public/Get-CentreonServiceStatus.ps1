function Get-CentreonServiceStatus{
    <#
    .SYNOPSIS
        This is a simple Powershell function to get real-time services information.

    .DESCRIPTION
        All monitoring information regarding services are available in throw the Centreon API. 
        With this call, you can also get host informations in the same time that service information. 
        This web service provide the same possibility that the service monitoring view.

    .EXAMPLE
        Get-ServiceStatus -status all -order ASC -Session $Session  -fields description

        Get-ServiceStatus -status all -order ASC -Session $Session -search '%rsys%'

    .LINK
        https://documentation.centreon.com/docs/centreon/en/latest/api/api_rest/index.html#service-status
    #>

    
    [CmdletBinding(
        HelpURI = 'https://documentation.centreon.com/docs/centreon/en/2.8.x/api/api_rest/index.html#service-status'
    )]
    param(
        
        [parameter(Mandatory = $true, HelpMessage = "OpenConnecton Fist")]
        [object]$Session,

        [parameter(Mandatory = $false, HelpMessage = "select the predefined filter like in the monitoring view: all, unhandled, problems")]
        [ValidateSet("all", "unhandled", "problems")][string]$viewType = "all",

        [parameter(Mandatory = $false, HelpMessage = "the fields list that you want to get separated by a ',''")]
        [array]$fields,
        
        [parameter(Mandatory = $false, HelpMessage = "the status of services that you want to get (ok, warning, critical, unknown, pending, all)")]
        [ValidateSet("ok", "warning", "critical", "unknown", "pending", "all")][string]$status = "all",

        [parameter(Mandatory = $false, HelpMessage = "hostgroup id filter")]
        [int]$hostgroup,

        [parameter(Mandatory = $false, HelpMessage = "servicegroup id filter")]
        [int]$servicegroup,

        [parameter(Mandatory = $false, HelpMessage = "instance id filter")]
        [int]$instance,

        [parameter(Mandatory = $false, HelpMessage = "search pattern applyed on service")]
        [string]$search,

        [parameter(Mandatory = $false, HelpMessage = "search pattern applyed on host")]
        [string]$searchHost,

        [parameter(Mandatory = $false, HelpMessage = "search pattern applyed on output")]
        [string]$searchOutput,

        [parameter(Mandatory = $false, HelpMessage = "a specific criticity")]
        [string]$criticality,

        [parameter(Mandatory = $false, HelpMessage = "the order type (selected in the field list)")]
        [string]$sortType,

        [parameter(Mandatory = $false, HelpMessage = "number of line you want")]
        [int]$limit,

        [parameter(Mandatory = $false, HelpMessage = "page number")]
        [int]$number,

        [parameter(Mandatory = $false, HelpMessage = "ASC ou DESC")]
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