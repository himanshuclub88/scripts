$projectName = (Get-Item .).Name
$venvRoot = "C:\venvs\$projectName"

if (-not (Test-Path $venvRoot)) {
    Write-Host "No virtual environments found for $projectName"
    exit
}

$venvs = Get-ChildItem $venvRoot -Directory |
    Where-Object {
        Test-Path "$($_.FullName)\Scripts\Activate.ps1"
    }

if ($venvs.Count -eq 0) {
    Write-Host "No virtual environments found."
    exit
}

if ($venvs.Count -eq 1) {
    $selected = $venvs[0]
}
else {
    Write-Host ""
    Write-Host "Available environments:"
    Write-Host ""

    for ($i = 0; $i -lt $venvs.Count; $i++) {
        Write-Host "$($i + 1). $($venvs[$i].Name)"
    }

    Write-Host ""
    $choice = Read-Host "Choose environment"

    if ($choice -notmatch '^\d+$' -or
        [int]$choice -lt 1 -or
        [int]$choice -gt $venvs.Count) {
        Write-Host "Invalid choice."
        exit
    }

    $selected = $venvs[[int]$choice - 1]
}

Write-Host ""
Write-Host "Activating: $($selected.Name)"

& "$($selected.FullName)\Scripts\Activate.ps1"