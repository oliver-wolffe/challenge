function Get-ObjectKeyJson
{

    param (
        [PSCustomObject] $object,
        [string] $key
    )

    $path = $key -replace "/", "."
    $expression = "{0}.{1}" -f '$object', $path
    
    $value = invoke-expression $expression

    if ($value) {
        $result = @{$key = $value}
    }
    else {
        $result = @{$key = "value not found for this key"} 
    }

    return $result | convertTo-Json -depth 99

}

$ip = "169.254.169.254"
$uri = "http://{0}/metadata/instance?api-version=2021-02-01" -f $ip
$response = Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -NoProxy -Uri $uri 

$key = "compute/osProfile"

$value = Get-ObjectKeyJson -object $response -key $key







  

