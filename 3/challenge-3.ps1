function Get-ObjectKey
{

    param (
        [string] $objectJson,
        [string] $key
    )

    $object = $objectJson | ConvertFrom-Json

    $location = $key -replace "/", "."
    $expression = "{0}.{1}" -f '$object', $location
    
    $value = invoke-expression $expression

    if ($value) {
        $result = $value
    }
    else {
        $result = "value not found for this key"
    }

    return $result

}

#$object = '{"a":{"b":{"c":"d"}}}'
#key = 'a/b/c'

$object = '{
    "player1": {
        "name": "Gordon Banks",
        "attributes": {
            "position": "GKP",
            "appearances": "73"
        }
    }
}'

$key = "player1/name"
Get-ObjectKey -objectJson $object -Key $key
#returns "Gordon Banks"

$key = "player1/attributes/position"
Get-ObjectKey -objectJson $object -Key $key
#returns "GKP"

$key = "player1/attributes/appearances"
Get-ObjectKey -objectJson $object -Key $key
#returns "73"

$key = "player2/attributes/appearances"
Get-ObjectKey -objectJson $object -Key $key
#returns "value not found for this key"






