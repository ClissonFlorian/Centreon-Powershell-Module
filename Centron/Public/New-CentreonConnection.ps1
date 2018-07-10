function New-CentreonConnection{
      <#
        .SYNOPSIS
            Create a connection to Centreon server
        .DESCRIPTION
            Create a connection to Centreon server
        .PARAMETER Server
            Centreon server : IP address or Hostname 
        .EXAMPLE
            $Session = New-SSConnection -server 192.168.1.50
        .EXAMPLE
            $Credentials = Get-Credential -Message "Enter centreon credentials"
            $Session = New-SSConnection -server 192.168.1.50 -Credentials $Credentials
        .NOTE
            
            I have to find a way to know when the token will be expired or it is expired.

            #"Unauthorized" is the output when token is expired but I think it's not really clean to use this output as Indicator.

            I think centreon use the same param "Session Expiration Time" of the Web Interface for the API. The default value is 120minutes
            
            This param is available form the Web Interface to : Administration->Centreon UI-><Sessions Expiration Time>
            It's not yet possible to get this value from the API currently
            

        .OUTPUT 

            return object that contain : server address,url and token
    #>

    [CmdletBinding()]
    param(       
        [parameter(Mandatory = $true, HelpMessage = "Your centreon ip address or hostname")]
        [string]$server,
        $Credentials=(Get-Credential -Message "Enter centreon credentials")

    )

    $url = "$server/centreon/api/index.php?"

    $params = @{
        "username" = "$($Credentials.UserName)";
        "password" = "$($Credentials.GetNetworkCredential().Password)";
    }


    try{

        $auth = (Invoke-WebRequest  -Uri "$($url)action=authenticate"  -Method Post -Body $params)
    
    }catch {
     
        throw "$($error[0].ErrorDetails.Message)"
    }
    
    $authToken = ($auth | ConvertFrom-Json).authToken
    $token = @{}
    $token.Add("centreon-auth-token", "$authToken")

    $Session = @{

        server  = $server
        url     = "$url"
        token   = $token
    }

    return $Session
}