function Invoke-CentreonCommand {

     <#
        .SYNOPSIS
            Interact with the Centreon Objects.
        .PARAMETER Session
            Specify object get from New-CentreonCommand cmdlet.
        .PARAMETER object
            Specify Centreon Object. (Corresponds to -a option with Centreon Clapi).
        .PARAMETER actions
            Specify Centreon Action. (Corresponds to -o option with Centreon Clapi).
        .PARAMETER values
            Specify string arguments splited by ";"
        .EXAMPLE
            Invoke-CentreonCommand -Object <object> -action <action> 
        .EXAMPLE
            Invoke-CentreonCommand -Object host -action show
        .EXAMPLE
            Invoke-CentreonCommand -Object host -action add -Values "test;Test host;127.0.0.1;generic-host;central;Linux"
        .LINK 
            #To get informations about the Centreon API.
            https://documentation.centreon.com/docs/centreon/en/latest/api/api_rest/index.html
        .LINK
            https://documentation.centreon.com/docs/centreon-clapi/en/latest/objects/index.html
        .NOTES
            https://github.com/ClissonFlorian/Centreon-Powershell-Module
    #>
    
    param(
        
        [parameter(Mandatory = $true)]
        [object]$Session,

        [parameter(Mandatory = $true)]
        [string]$object,

        [parameter(Mandatory = $true)]
        [string]$action,

        [parameter(Mandatory = $false)]
        [string]$values
    )
    
        
    if($values){
        
        $body = @{
            "action" = "$action";
            "object" = "$object";
            "values" = "$values";
        }
    }else{
        
        $body = @{
            "action" = "$action";
            "object" = "$object";
        }
    }
    
   $output = (Invoke-WebRequest -ContentType "application/json" -Uri "$($Session.url)action=action&object=centreon_clapi" -Method Post -Headers $($Session.token) -Body (ConvertTo-Json $body)).Content | ConvertFrom-Json
   return $output.result
}