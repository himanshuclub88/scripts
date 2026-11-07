# Activate the virtual environment for the current project.
# Run this script from the project directory in PowerShell.

$projectName = (Get-Item -LiteralPath (Get-Location).Path).Name
$venvRoot = Join-Path 'C:\venvs' $projectName

if (-not (Test-Path -LiteralPath $venvRoot -PathType Container)) {
    Write-Host "No virtual environment folder found for '$projectName'." -ForegroundColor Yellow
    Write-Host "Expected: $venvRoot"
    return
}

$venvs = @(
    Get-ChildItem -LiteralPath $venvRoot -Directory |
        Where-Object {
            Test-Path -LiteralPath (Join-Path $_.FullName 'Scripts\Activate.ps1') -PathType Leaf
        } |
        Sort-Object Name
)

if ($venvs.Count -eq 0) {
    Write-Host "No valid virtual environments found in: $venvRoot" -ForegroundColor Yellow
    return
}

if ($venvs.Count -eq 1) {
    $selected = $venvs[0]
}
else {
    Write-Host ''
    Write-Host "Available environments for $projectName:" -ForegroundColor Cyan
    Write-Host ''

    for ($i = 0; $i -lt $venvs.Count; $i++) {
        Write-Host ("  {0}. {1}" -f ($i + 1), $venvs[$i].Name)
    }

    Write-Host ''
    $choiceText = Read-Host "Choose environment [1-$($venvs.Count)]"

    if ($choiceText -notmatch '^\d+$') {
        Write-Host 'Invalid choice.' -ForegroundColor Red
        return
    }

    $choice = [int]$choiceText
    if ($choice -lt 1 -or $choice -gt $venvs.Count) {
        Write-Host 'Invalid choice.' -ForegroundColor Red
        return
    }

    $selected = $venvs[$choice - 1]
}

$activateScript = Join-Path $selected.FullName 'Scripts\Activate.ps1'

Write-Host ''
Write-Host "Activating: $($selected.Name)" -ForegroundColor Green

# Invoke the standard activation script in this PowerShell process.
& $activateScript

if ($env:VIRTUAL_ENV) {
    Write-Host "Active environment: $env:VIRTUAL_ENV" -ForegroundColor Green
}
