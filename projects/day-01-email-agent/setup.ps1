param(
    [switch]$SkipInstall
)
$ErrorActionPreference = "Stop"

if (-not (Get-Command py -ErrorAction SilentlyContinue)) {
    throw "Python launcher 'py' not found. Install Python 3.10+ and reopen VS Code."
}

if (-not (Test-Path ".venv")) {
    py -3 -m venv .venv
}

$python = Join-Path (Get-Location) ".venv\Scripts\python.exe"
& $python -m pip install --upgrade pip
if (-not $SkipInstall) {
    & $python -m pip install -r requirements.txt
}

if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    Write-Host "Created .env. Edit it with your Bedrock region and model ID."
}
Write-Host "Setup ready. In VS Code, use Run and Debug > Day 1: Email agent."
