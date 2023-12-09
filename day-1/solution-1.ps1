$PuzzleInput = Get-Content $PSScriptRoot/input.txt

$answer = 0
$PuzzleInput | ForEach-Object {
    #$line = ($_ | Select-String '[^0-9]+').Matches.Value
    $line = $_ -replace '[^0-9]+', ''
    
    if ($line.Length -le 0) {
        $lineInfo = [PSCustomObject]@{
            first = 0
            last = 0
        }
    } elseif ($line.Length -eq 1){
        $lineInfo = [PSCustomObject]@{
            first = $line[0]
            last = $line[0]
        }
    } else {
        $lineInfo = [PSCustomObject]@{
            first = $line[0]
            last = $line[$line.Length - 1]
        }
    }
    $lineInfo
    $answer += $lineInfo.first + $lineInfo.last
}

$answer