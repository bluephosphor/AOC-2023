$PuzzleInput = Get-Content $PSScriptRoot\sample-input.txt

function Get-ParsedLineData {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Line
    )

    $gameInfo = $Line.Split(':')
    $gameNumber = $gameInfo[0].Split(' ')[1]
    $setInfo = $gameInfo[1].Split(';')
    
    For ($i = 0; $i -lt $setInfo.Length; $i++){
        $cubeInfo = $setInfo[$i].Split(',')
        foreach ($cube in $cubeInfo){
            $cubeAttributes = $cube.Split(' ')
            [PSCustomObject]@{
                Color = $cubeAttributes[2]
                Quantity = $cubeAttributes[1]
                Set = $i
                Game = $gameNumber
            }
        }
    }
    Return
}

$PuzzleInput | ForEach-Object {
    $gameData = Get-ParsedLineData -Line $_
    $gameData
}