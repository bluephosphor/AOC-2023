$PuzzleInput = Get-Content $PSScriptRoot/input.txt

$patterns = @(
    'one','two','three','four','five','six','seven','eight','nine'
    '1','2','3','4','5','6','7','8','9'
)

function stringToNum {
    param(
        [Parameter(Mandatory=$true)]
        [string]$str
    )

    switch($str) {
        'one'   { Return [int]1 }
        'two'   { Return [int]2 }
        'three' { Return [int]3 }
        'four'  { Return [int]4 }
        'five'  { Return [int]5 }
        'six'   { Return [int]6 }
        'seven' { Return [int]7 }
        'eight' { Return [int]8 }
        'nine'  { Return [int]9 }
        Default { Return [int]$str }
    }
}

function resolveLine {
    param(
        [Parameter(Mandatory=$true)]
        [string]$line 
    )
    
    $lineMatches = @()
    foreach ($pattern in $patterns) {
        $lineMatches += ($line | Select-String $pattern -AllMatches).Matches
    }
    
    $sortedMatches = $lineMatches | Sort-Object Index
    
    if ($VerbosePreference) { $sortedMatches | Format-Table }

    $first = [string]$sortedMatches[0].Value
    $last  = [string]$sortedMatches[$sortedMatches.Length - 1].Value

    "Adding $first and $last..."

    Return (stringToNum -str $first) + (stringToNum -str $last)
}

$total = 0
$PuzzleInput | ForEach-Object {
    $result = resolveLine -line $_
    $total += $result[1]
}

$total
