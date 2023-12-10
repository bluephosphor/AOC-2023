$PuzzleInput = Get-Content $PSScriptRoot/input.txt

function Get-ResolvedNumber {
    param(
        [Parameter(Mandatory=$true)]
        [string]$str
    )

    switch($str) {
        'one'   { Return '1' }
        'two'   { Return '2' }
        'three' { Return '3' }
        'four'  { Return '4' }
        'five'  { Return '5' }
        'six'   { Return '6' }
        'seven' { Return '7' }
        'eight' { Return '8' }
        'nine'  { Return '9' }
        Default { Return $str }
    }
}

function Get-ResolvedLine {
    param(
        [Parameter(Mandatory=$true)]
        [string]$line 
    )

    $patterns = @(
        'one','two','three','four','five','six','seven','eight','nine'
        '1','2','3','4','5','6','7','8','9'
    )
    
    $lineMatches = @()
    foreach ($pattern in $patterns) {
        $lineMatches += ($line | Select-String $pattern -AllMatches).Matches
    }
    
    $sortedMatches = $lineMatches | Sort-Object Index
    
    $first = [string]$sortedMatches[0].Value
    $last  = [string]$sortedMatches[$sortedMatches.Length - 1].Value

    Return [PSCustomObject]@{
        Line = $line
        Action = "Choosing $first and $last..."
        Result = (Get-ResolvedNumber -str $first) + (Get-ResolvedNumber -str $last)
        SotredMatches = $sortedMatches
    }
}

$total = 0
$infoList = @()

$PuzzleInput | ForEach-Object {
    $info = Get-ResolvedLine -line $_ -Verbose
    $infoList += $info
    $total += [int]$info.Result
}

if ($VerbosePreference) {
    $infoList | Format-Table -AutoSize
}
$total
