param(
    [Parameter(Mandatory=$true)]
    [int]$Day,

    [Parameter(Mandatory=$true)]
    [int]$Solution
)

Write-Host "Running Solution: $Solution for Day: $Day..." -ForegroundColor Green

$targetPath = "$PSScriptRoot\day-$Day\solution-$Solution.ps1"

if (Test-Path $targetPath) {
    Invoke-Expression $targetPath
} else {
    Write-Error "Solution not found at path $targetPath"
}