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
   
   
   
   