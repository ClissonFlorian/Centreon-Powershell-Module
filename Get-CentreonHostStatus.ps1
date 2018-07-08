function Get-CentreonHostStatus {
  <#
    .SYNOPSIS
        This is a simple Powershell function to get real-time hosts information.

    .DESCRIPTION
        All monitoring information regarding host are available in throw the Centreon API. 
        With this call, you can also get host informations in the same time that service information. 
        This web service provide the same possibility that the service monitoring view.

    .EXAMPLE
        Get-HostStatus -status all -order ASC -fields description -Session $Session

    .EXAMPLE
        Get-HostStatus -search 'cent%' -Session $Session

    .LINK

        https://documentation.centreon.com/docs/centreon/en/latest/api/api_rest/index.html#host-status
  #>


    
    [CmdletBinding(
        HelpURI = 'https://documentation.centreon.com/docs/centreon/en/2.8.x/api/api_rest/index.html#host-status'
    )]
    param(
           
        [parameter(Mandatory = $true, HelpMessage = "OpenConnecton Fist")]
        [object]$Session,

        [parameter(Mandatory = $false, HelpMessage = "select the predefined filter like in the monitoring view: all, unhandled, problems")]
        [ValidateSet("all", "unhandled", "problems")][string]$viewType = "all",

        [parameter(Mandatory = $false, HelpMessage = "the fields list that you want to get separated by a ',''")]
        [array]$fields,
        
        [parameter(Mandatory = $false, HelpMessage = "the status of services that you want to get (ok, warning, critical, unknown, pending, all)")]
        [ValidateSet("up", "down", "unreachable", "pending", "all")][string]$status = "all",

        [parameter(Mandatory = $false, HelpMessage = "hostgroup id filter")]
        [int]$hostgroup,

        [parameter(Mandatory = $false, HelpMessage = "instance id filter")]
        [int]$instance,

        [parameter(Mandatory = $false, HelpMessage = "search pattern applyed on host name")]
        [string]$search,

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

    $cmdline = "object=centreon_realtime_hosts&action=list"
   
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