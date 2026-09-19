param(
    [string]$VenvName = ".venv",
    [string]$Requirements = "requirements.txt"
)

$projectName = (Get-Item .).Name
$venv = "C:\venvs\$projectName\$VenvName"

Write-Host "Project: $projectName"
Write-Host "Creating venv: $venv"

python -m venv $venv

if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to create virtual environment."
    exit 1
}

& "$venv\Scripts\Activate.ps1"

python -m pip install --upgrade pip

pip install -r $Requirements

Write-Host ""
Write-Host "Done!"
Write-Host "Venv: $venv"
Write-Host "Requirements: $Requirements"