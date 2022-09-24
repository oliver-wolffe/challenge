function Get-ObjectKeyValue
{

    param (
        [PSCustomObject] $object,
        [string] $key
    )

    $path = $key -replace "/", "."
    $expression = "{0}.{1}" -f '$object', $path
    
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

$object = [PSCustomObject]@{
    player1 = @{
        name = "Gordon Banks"
        attributes = @{
            position = "GKP"
            appearances = "73"
        }
    }
}

$key = "player1/name"
Get-ObjectKeyValue -object $object -key $key
#returns "Gordon Banks"

$key = "player1/attributes/position"
Get-ObjectKeyValue -object $object -key $key
#returns "GKP"

$key = "player1/attributes/appearances"
Get-ObjectKeyValue -object $object -key $key
#returns "73"

$key = "player2/attributes/appearances"
Get-ObjectKeyValue -object $object -key $key
#returns "value not found for this key"






