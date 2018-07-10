function Invoke-CentreonCommand {

     <#
        .SYNOPSIS
            Call Centreon API
        .DESCRIPTION
            Call Centreon API and return objects

            Please report you to the centreon clapi documentation to get the objects available.

            https://documentation.centreon.com/docs/centreon-clapi/en/latest/objects/index.html
       
        .PARAMETER Session
            Have to contains url,server,token
        .PARAMETER object
            The key object corresponds to the option -o in Centreon CLAPI, the value HOST corresponds to the -o option value.
        .PARAMETER actions
            The key action corresponds to the option -a in Centreon CLAPI, the value show corresponds to the -a option value
        .PARAMETER values
            string arguments splited by ";"
        .EXAMPLE
           
           #Run-ClapiCommand -Object <object> -action <action>
            
        .EXAMPLE
            Run-ClapiCommand -Object host -action show
        .EXAMPLE
            
            Run-ClapiCommand -Object host -action add -Values "test;Test host;127.0.0.1;generic-host;central;Linux"

        .LINK 
            #to get informations about the APi
            https://documentation.centreon.com/docs/centreon/en/latest/api/api_rest/index.html

        .LINK
            https://documentation.centreon.com/docs/centreon-clapi/en/latest/objects/index.html
    #>
    
    
    param(
        
        [parameter(Mandatory = $true, HelpMessage = "OpenConnecton Fist")]
        [object]$Session,

        [parameter(Mandatory = $true, HelpMessage = "object name")]
        [string]$object,

        [parameter(Mandatory = $true, HelpMessage = "action name")]
        [string]$action,

        [parameter(Mandatory = $false, HelpMessage = "value string")]
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