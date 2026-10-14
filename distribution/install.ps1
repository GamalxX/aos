<#
.SYNOPSIS
AOS Frictionless One-Line Onboarding Installer for Windows PowerShell
#>

$ErrorActionPreference = "Stop"

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host " ⚡ Installing AOS (Agent Operating System)" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan

# 1. Detect Python 3.11+
$py = Get-Command python -ErrorAction SilentlyContinue
if (-not $py) {
    Write-Error "Python 3 is required but was not found in PATH. Please install Python 3.11+."
    exit 1
}

$pyVer = & python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
$major, $minor = $pyVer.Split('.')
if ([int]$major -lt 3 -or ([int]$major -eq 3 -and [int]$minor -lt 11)) {
    Write-Error "AOS requires Python 3.11+. Detected: Python $pyVer"
    exit 1
}
Write-Host " • Python Version: $pyVer (OK)" -ForegroundColor Green

# 2. Virtual Environment Setup
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($scriptDir -like "*scripts*") {
    $repoRoot = Split-Path -Parent $scriptDir
} else {
    $repoRoot = $scriptDir
}

$venvDir = Join-Path $repoRoot ".venv"
$venvPy = Join-Path $venvDir "Scripts\python.exe"

if (-not (Test-Path $venvPy)) {
    Write-Host " • Creating virtual environment in $venvDir..." -ForegroundColor Cyan
    & python -m venv $venvDir
}

# 3. Locate & Install Wheel Package
$wheel = Get-ChildItem -Path (Join-Path $repoRoot "dist") -Filter "*.whl" -ErrorAction SilentlyContinue | Select-Object -Last 1

if ($wheel) {
    Write-Host " • Installing AOS from package: $($wheel.Name)..." -ForegroundColor Cyan
    & $venvPy -m pip install $wheel.FullName --force-reinstall --quiet
} else {
    Write-Host " • Fetching latest release package..." -ForegroundColor Cyan
    $releaseUrl = "https://github.com/GamalxX/aos/releases/latest/download/aos-1.0.0-py3-none-any.whl"
    try {
        & $venvPy -m pip install $releaseUrl --force-reinstall --quiet
    } catch {
        & $venvPy -m pip install aos --quiet
    }
}

# 4. Auto-Inject MCP Config for Detected Editors
$aosExe = Join-Path $venvDir "Scripts\aos.exe"
if (Test-Path $aosExe) {
    Write-Host " • Injecting MCP configuration into detected IDEs..." -ForegroundColor Cyan
    & $aosExe setup
    Write-Host " • Running system diagnostics..." -ForegroundColor Cyan
    & $aosExe doctor
} else {
    & $venvPy -m app.client.entrypoint setup
    & $venvPy -m app.client.entrypoint doctor
}

Write-Host "=====================================================" -ForegroundColor Green
Write-Host " ✅ AOS Setup Complete!" -ForegroundColor Green
Write-Host " Control Center UI:  http://127.0.0.1:4141" -ForegroundColor Yellow
Write-Host " Run MCP Server:     aos-mcp" -ForegroundColor Cyan
Write-Host " Run Control Center: aos-settings" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Green
