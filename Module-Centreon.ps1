#Default crendentials from centreon
$params = @{
    "username" = "admin";
    "password" = "centreon";
}
   
   
#my custom settings
$server = "192.168.0.30"
$url = "$server/centreon/api/index.php?"
   
   
#auth
$auth = Invoke-WebRequest  -Uri "$($url)action=authenticate"  -Method Post -Body $params 
$token = ($auth | ConvertFrom-Json).authToken
   
$headers = @{}
$headers.Add("centreon-auth-token", "$token")
   
   
#service query
$query = Invoke-WebRequest -ContentType "application/json" -Uri "$($url)object=centreon_realtime_services&action=list" -Method Get  -Headers $headers
   
$query | ConvertFrom-Json
   
   
#add host
   
$body = @{
    "action" = "add";
    "object" = "host";
    "values" = "test;Test host;127.0.0.1;OS-Windows-SNMP;central;Centreon_platform";
}
   
   
try {
   
    Invoke-WebRequest -ContentType "application/json" -Uri "$($url)action=action&object=centreon_clapi" -Method Post -Headers $headers -Body (ConvertTo-Json $body) | Out-Null
      
}
catch {
   
    Write-host $Error[0] -ForegroundColor Red
}
   
function ClapiQuery() {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $True)]
        [string]$action,
        [parameter(Mandatory = $True)]
        [string]$object,
        [parameter(Mandatory = $True)]
        [string]$value
    )
     
    
    $body = @{
        "action" = "$action";
        "object" = "$object";
        "values" = "$value";
    }


    try {
   
        Invoke-WebRequest -ContentType "application/json" -Uri "$($url)action=action&object=centreon_clapi" -Method Post -Headers $headers -Body (ConvertTo-Json $body) | Out-Null
          
    }
    catch {
       
        Write-host $Error[0] -ForegroundColor Red
    }
}

function Get-ServiceStatus() {
    [CmdletBinding()]
    param(

        [parameter(Mandatory = $false, HelpMessage = "select the predefined filter like in the monitoring view: all, unhandled, problems")]
        [ValidateSet("all", "unhandled", "problems")][string]$viewType = "all",

        [parameter(Mandatory = $false, HelpMessage = "the fields list that you want to get separated by a ',''")]
        [string]$fields,
        
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
        [string]$order = "ASC"
    )

 
    
    $options = @()

    #get function name and arguments
    (Get-Command ($MyInvocation.MyCommand).Name).parameters.Keys | ForEach-Object {

        $ValueFromVariable = Get-Variable $_
        $option = ($ValueFromVariable).Name
        $value = ($ValueFromVariable).Value

        if ($value) {
            $options += ("$option=$value")
        }

    }

    $cmdline = "api.domain.tld/centreon/api/index.php?action=list&object=centreon_realtime_services"
    $options = $options -join "&"

    $query = "$cmdline&$options" 
    #"&limit=60&viewType=all&sortType=name&order=desc&fields=id,description,host_id,host_name,state,output"

}



   
   