function New-CentreonConnection{
      <#
        .SYNOPSIS
            Authenticate against the Rest API.
        .PARAMETER Server
            Specify the IP address or the Hostname of the Centreon Server.
        .PARAMETER Credentials
            Specify Centreon Credentials.
        .EXAMPLE
            $Session = New-SSConnection -server 192.168.1.50
        .EXAMPLE
            $Credentials = Get-Credential -Message "Enter centreon credentials"
            $Session = New-SSConnection -server 192.168.1.50 -Credentials $Credentials
        .OUTPUTS
            System.Object. Returns object with server,url and token.
        .NOTES
            https://github.com/ClissonFlorian/Centreon-Powershell-Module
    #>

    [CmdletBinding()]
    param(       
        [parameter(Mandatory = $true)]
        [string]$server,
        [parameter(Mandatory = $false)]
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